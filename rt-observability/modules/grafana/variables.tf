# Grafana variables
variable "grafana_image" {
  description = "Grafana Docker image"
  type        = string
}

variable "grafana_replicas" {
  description = "Number of Grafana replicas"
  type        = number
}

variable "grafana_admin_user" {
  description = "Grafana admin user"
  type        = string
}

variable "grafana_admin_password" {
  description = "Grafana admin password"
  type        = string
}

variable "grafana_config_data" {
  description = "Grafana configuration data"
  type        = string
}