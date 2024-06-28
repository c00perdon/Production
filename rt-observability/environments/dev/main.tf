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
  prometheus_config_data       = var.prometheus_config_data
}
