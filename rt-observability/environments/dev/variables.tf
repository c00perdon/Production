variable "prometheus_image" {
  description = "Docker image for Prometheus"
  type        = string
  default     = "prom/prometheus:v2.30.3"
}

variable "prometheus_replicas" {
  description = "Number of replicas for Prometheus deployment"
  type        = number
  default     = 1
}


variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "C:/Users/COOPS/.kube/config"
}

variable "prometheus_scrape_interval" {
  description = "Scrape interval for Prometheus"
  type        = string
  default     = "15s"
}

variable "prometheus_storage_retention" {
  description = "Time duration for which data should be retained in Prometheus"
  type        = string
  default     = "12h"
}

variable "prometheus_config_data" {
  description = "Prometheus configuration data"
  type = object({
    global = object({
      scrape_interval = string
    })
    scrape_configs = list(object({
      job_name = string
      static_configs = list(object({
        targets = list(string)
      }))
    }))
  })
}

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