## Terraform Docker Container Module
This Terraform module is based on the [kreuzwerker/docker](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs) provider's [docker_container](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/container). By wrapping it, this module allows for a more dynamic list/map-based definition of variables, making it more streamlined and clean for small homelab service management. Note that this is work in progress and does not map all the original container resource inputs.

## Usage

Refer to the [examples](./examples) for detailed usage.
