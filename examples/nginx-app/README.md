## Terraform Nginx Proxy Container Submodule

This submodule is used to manage Nginx proxy containers using the [kreuzwerker/docker](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs) provider. It sets up Docker networks and pulls the latest Nginx image to run proxy applications in both host and bridge network modes.

### Variables

- No additional variables are required for this submodule.

### Providers

- `docker`: Configured for local or remote Docker host based on the `provider.tf` configuration.

### Resources

- `docker_network.app_network_1`: Docker network for the first application network.
- `docker_network.app_network_2`: Docker network for the second application network.
- `docker_registry_image.nginx`: Docker registry image for Nginx.
- `docker_image.nginx`: Docker image for Nginx.

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

These commands will set up the necessary Docker networks and pull the required Docker images to run the Nginx proxy applications in both host and bridge network modes.