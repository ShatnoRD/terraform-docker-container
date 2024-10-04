# https://hub.docker.com/r/cloudflare/cloudflared
resource "docker_network" "cloudflared" {
  name   = "cloudflared-tunnel-network"
  driver = "bridge"
}

data "docker_registry_image" "cloudflared" {
  name = "cloudflare/cloudflared:latest"
}
resource "docker_image" "cloudflared" {
  name          = data.docker_registry_image.cloudflared.name
  pull_triggers = [data.docker_registry_image.cloudflared.sha256_digest]
}

module "cloudflared" {
  source  = "ShatnoRD/container/docker"

  image_id          = docker_image.cloudflared.image_id
  container_name    = "cloudflared-app"
  container_command = ["tunnel", "--no-autoupdate", "run"]

  labels = {
    "logging"         = "tunnels",
    "logging_jobname" = "cloudflared"
  }
  envs = {
    "TUNNEL_TOKEN" = var.cloudflare_tunnel_token
  }
  networks = [{ driver = "host" }]
}