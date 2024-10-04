## Terraform Drone CI/CD Submodule

This submodule is used to manage a Drone CI/CD setup using the [kreuzwerker/docker](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs) provider. It sets up Docker networks and pulls the necessary Docker images to run Drone server, Drone runner, and a PostgreSQL database.

### Variables

- `host_data_path`: Path to the location of the repository containing the configs.
- `github_oauth_app_client_id`: GitHub OAuth application client ID.
- `github_oauth_app_client_secret`: GitHub OAuth application client secret.
- `drone_hostname`: Hostname for the Drone server.

### Providers

- `docker`: Configured for local Docker host.

### Resources

- `random_password.db_password`: Generates a random password for the PostgreSQL database.
- `random_string.rpc_secret`: Generates a random secret for RPC communication.
- `docker_network.drone`: Docker network for Drone.
- `docker_registry_image.postgres_15`: Docker registry image for PostgreSQL 15.
- `docker_image.drone_postgres`: Docker image for PostgreSQL.
- `docker_registry_image.drone`: Docker registry image for Drone server.
- `docker_image.drone`: Docker image for Drone server.
- `docker_registry_image.drone_runner`: Docker registry image for Drone runner.
- `docker_image.drone_runner`: Docker image for Drone runner.
### Usage

To initialize and apply the Terraform configuration, follow these steps:

1. **Initialize the Terraform configuration:**
    ```sh
    terraform init
    ```

2. **Apply the Terraform configuration:**
    ```sh
    terraform apply
    ```

    You will be prompted to confirm the changes. Type `yes` to proceed.

These commands will set up the necessary Docker networks and pull the required Docker images to run the Drone CI/CD setup.