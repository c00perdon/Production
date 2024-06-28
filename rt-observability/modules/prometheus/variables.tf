# prometheus/variables.tf

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
  description = "Data for prometheus.yml configuration"
  type        = map
  default     = {
    global = {
      scrape_interval = var.prometheus_scrape_interval
    }
    scrape_configs = [
      {
        job_name     = "prometheus"
        static_configs = [
          {
            targets = ["localhost:9090"]
          }
        ]
      }
    ]
  }
}
