# https://docs.drone.io/server/provider/github/
resource "random_password" "db_password" {
    length           = 16
    special          = true
    override_special = "_%@"
}
resource "random_string" "rpc_secret" {
    length  = 32
    special = false
    upper   = false
    numeric = true
    lower   = true
}

resource "docker_network" "drone" {
    name   = "drone-network"
    driver = "bridge"
}

data "docker_registry_image" "postgres_15" {
    name = "postgres:15"
}
resource "docker_image" "drone_postgres" {
    name          = data.docker_registry_image.postgres_15.name
    pull_triggers = [data.docker_registry_image.postgres_15.sha256_digest]
    keep_locally  = true
}
data "docker_registry_image" "drone" {
    name = "drone/drone:2"
}
resource "docker_image" "drone" {
    name          = data.docker_registry_image.drone.name
    pull_triggers = [data.docker_registry_image.drone.sha256_digest]
}
data "docker_registry_image" "drone_runner" {
    name = "drone/drone-runner-docker:1"
}
resource "docker_image" "drone_runner" {
    name          = data.docker_registry_image.drone_runner.name
    pull_triggers = [data.docker_registry_image.drone_runner.sha256_digest]
    keep_locally  = true
}

module "postgres" {
    source = "../../"

    image_id       = docker_image.drone_postgres.image_id
    container_name = "drone-db"

    labels = {
        "logging"         = "cicd",
        "logging_jobname" = "database"
    }
    volumes = [
        {
            host_path      = "${var.host_data_path}/drone/postgres"
            container_path = "/var/lib/postgresql/data"
        }
    ]
    envs = {
        POSTGRES_DB       = "drone"
        POSTGRES_USER     = "drone"
        POSTGRES_PASSWORD = random_password.db_password.result
    }
    networks = [{
        name   = docker_network.drone.name
        driver = docker_network.drone.driver
    }]
}
module "drone" {
    source = "../../"

    image_id       = docker_image.drone.image_id
    container_name = "drone-app"

    labels = {
        "logging"         = "cicd",
        "logging_jobname" = "server"
    }
    ports = {
        80 : 80
    }
    envs = {
        DRONE_GITHUB_CLIENT_ID     = var.github_oauth_app_client_id
        DRONE_GITHUB_CLIENT_SECRET = var.github_oauth_app_client_secret
        DRONE_RPC_SECRET           = random_string.rpc_secret.result
        DRONE_AGENTS_ENABLED       = "true"
        DRONE_SERVER_HOST          = var.drone_hostname
        DRONE_SERVER_PROTO         = "https"
        DRONE_USER_FILTER          = "username,organization"
        DRONE_USER_CREATE          = "username:username,admin:true"
        DRONE_DATABASE_DRIVER      = "postgres"
        DRONE_DATABASE_DATASOURCE  = "postgres://drone:${random_password.db_password.result}@${module.postgres.container_name}:5432/drone?sslmode=disable"
    }
    networks = [{
        name   = docker_network.drone.name
        driver = docker_network.drone.driver
    }]
}
module "drone-runner" {
    source = "../../"

    image_id       = docker_image.drone_runner.image_id
    container_name = "drone-runner"

    labels = {
        "logging"         = "cicd",
        "logging_jobname" = "runner"
    }
    volumes = [
        {
            host_path      = "/var/run/docker.sock"
            container_path = "/var/run/docker.sock"
        }
    ]
    envs = {
        DRONE_RPC_SECRET = random_string.rpc_secret.result,
        DRONE_RPC_HOST   = module.drone.container_name,
        DRONE_RPC_PROTO  = "http",
    }
    networks = [{
        name   = docker_network.drone.name
        driver = docker_network.drone.driver
    }]
}
