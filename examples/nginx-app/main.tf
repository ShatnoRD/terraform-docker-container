resource "docker_network" "app_network_1" {
    name   = "app-network-1"
    driver = "bridge"
}
resource "docker_network" "app_network_2" {
    name   = "app-network-2"
    driver = "bridge"
}

data "docker_registry_image" "nginx" {
    name = "nginx:latest"
}
resource "docker_image" "nginx" {
    name          = data.docker_registry_image.nginx.name
    pull_triggers = [data.docker_registry_image.nginx.sha256_digest]
    keep_locally  = true
}

module "proxy_app_hostmode" {
   source  = "ShatnoRD/container/docker"

    image_id       = docker_image.nginx.image_id
    container_name = "nginx-proxy-app1"

    labels = {
        "logging"         = "proxies",
        "logging_jobname" = "proxy_app_hostmode"
    }
    ports = {
        80 : 80
    }
    networks = [{ 
        driver = "host"
    }]
}
module "proxy_app_bridgemode" {
   source  = "ShatnoRD/container/docker"

    image_id       = docker_image.nginx.image_id
    container_name = "nginx-proxy-app2"

    labels = {
        "logging"         = "proxies",
        "logging_jobname" = "proxy_app_hostmode"
    }
    ports = {
        81 : 80
    }
    networks = [{ 
        name = docker_network.app_network_1.name
        driver = docker_network.app_network_1.driver
        aliases = ["proxy_app_bridgemode_1"]
    },
    { 
        name = docker_network.app_network_2.name
        driver = docker_network.app_network_2.driver
        aliases = ["proxy_app_bridgemode_2"]
    }]
}

output "proxy_app_hostmode_container_id" {
        description = "The ID of the Docker container for proxy_app_hostmode."
        value       = module.proxy_app_hostmode.container_id
}
output "proxy_app_hostmode_container_name" {
        description = "The name of the Docker container for proxy_app_hostmode."
        value       = module.proxy_app_hostmode.container_name
}
output "proxy_app_hostmode_container_network_data" {
        description = "The network data of the Docker container for proxy_app_hostmode."
        value = module.proxy_app_hostmode.container_network_data
}

output "proxy_app_bridgemode_container_id" {
        description = "The ID of the Docker container for proxy_app_bridgemode."
        value       = module.proxy_app_bridgemode.container_id
}
output "proxy_app_bridgemode_container_name" {
        description = "The name of the Docker container for proxy_app_bridgemode."
        value       = module.proxy_app_bridgemode.container_name
}
output "proxy_app_bridgemode_container_network_data" {
        description = "The network data of the Docker container for proxy_app_hostmode."
        value = module.proxy_app_bridgemode.container_network_data
}
