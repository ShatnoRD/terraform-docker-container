## Terraform Cloudflare Container Submodule

This submodule is used to manage a Cloudflare container using the [kreuzwerker/docker](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs) provider. It sets up a Docker network and pulls the latest Cloudflare image to run a Cloudflare tunnel.

### Variables

- `cloudflare_tunnel_token`: (Required) Cloudflare tunnel token.

### Providers

- `docker`: Configured for local or remote Docker host based on the `provider.tf` configuration.

### Resources

- `docker_network.cloudflared`: Docker network for Cloudflare tunnel.
- `docker_registry_image.cloudflared`: Docker registry image for Cloudflare tunnel.
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

These commands will set up the necessary Docker networks and pull the required Docker images to run the Cloudflare tunnel setup.