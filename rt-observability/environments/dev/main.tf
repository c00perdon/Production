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

module "grafana" {
  source = "git::https://github.com/c00perdon/Production.git//rt-observability/modules/grafana"

  grafana_image       = var.grafana_image
  grafana_replicas    = var.grafana_replicas
  grafana_admin_user  = var.grafana_admin_user
  grafana_admin_password = var.grafana_admin_password
  grafana_config_data = var.grafana_config_data

}