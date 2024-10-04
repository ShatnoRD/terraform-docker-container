variable "host_data_path" {
  description = "path to the location of the repository containing the configs"
  type        = string
  default     = "/etc/user/data"
}

variable "host_ip_address" {
  type    = string
  default = "127.0.0.1"
}

variable "ssh_user" {
  type    = string
  default = "root"
}
variable "ssh_password" {
  type      = string
  default   = "root"
  sensitive = true
}
variable "ssh_port" {
  type    = number
  default = "22"
}
variable "ssh_key_file" {
  type    = string
  default = "~/.ssh/terraform"
}

variable "github_oauth_app_client_id" {
  type      = string
  sensitive = true
}
variable "github_oauth_app_client_secret" {
  type      = string
  sensitive = true
}

variable "drone_hostname" {
  type = string
}