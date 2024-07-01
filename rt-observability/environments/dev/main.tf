terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 1.11.1"  
    }
  }
}

provider "kubernetes" {
  host = "https://127.0.0.1:62032" 
  insecure = true 
  config_path = var.kubeconfig_path  
}

module "prometheus" {
  source = "git::https://github.com/c00perdon/Production.git//rt-observability/modules/prometheus"

  prometheus_image             = var.prometheus_image
  prometheus_replicas          = var.prometheus_replicas
  prometheus_scrape_interval   = var.prometheus_scrape_interval
  prometheus_storage_retention = var.prometheus_storage_retention
  prometheus_config_data       = var.prometheus_config_data
}
