terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 1.11.1"  # Adjust version as needed
    }
  }
}

provider "kubernetes" {
  # Optionally specify a kubeconfig file. If not provided, the default kubeconfig will be used.
}

module "prometheus" {
  source = "git::https://github.com/c00perdon/Production.git//rt-observability/modules/prometheus"

  prometheus_image             = var.prometheus_image
  prometheus_replicas          = var.prometheus_replicas
  prometheus_scrape_interval   = var.prometheus_scrape_interval
  prometheus_storage_retention = var.prometheus_storage_retention
  prometheus_config_data       = merge(
    {
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
    },
    var.prometheus_config_data
  )
}

variable "prometheus_image" {
  description = "Docker image for Prometheus"
  type        = string
}

variable "prometheus_replicas" {
  description = "Number of replicas for Prometheus deployment"
  type        = number
}

variable "prometheus_scrape_interval" {
  description = "Scrape interval for Prometheus"
  type        = string
}

variable "prometheus_storage_retention" {
  description = "Time duration for which data should be retained in Prometheus"
  type        = string
}

variable "prometheus_config_data" {
  description = "Data for prometheus.yml configuration"
  type        = map
}
