terraform {
    required_providers {
        docker = {
            source  = "kreuzwerker/docker"
            version = "3.0.2"
        }
    }
}

# local docker host with no authentication
provider "docker" {}

# # remote docker host with ssh authentication
# provider "docker" {
#     host = "ssh://${var.ssh_user}@${var.host_ip_address}:${var.ssh_port}"
#     ssh_opts = [
#         "-o", "StrictHostKeyChecking=no",
#         "-o", "UserKnownHostsFile=/dev/null",
#         "-i", "${var.ssh_key_file}"
#     ]
# }
