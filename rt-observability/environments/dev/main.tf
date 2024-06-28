# environments/dev/main.tf

provider "kubernetes" {
  # Optionally specify a kubeconfig file. If not provided, the default kubeconfig will be used.
}

module "prometheus" {
  source = "git::https://github.com/c00perdon/Production.git//rt-observability/modules/prometheus"

  # Variables specific to the dev environment
  prometheus_image             = "prom/prometheus:v2.30.3"
  prometheus_replicas          = 1
  prometheus_scrape_interval   = "15s"
  prometheus_storage_retention = "12h"

  # You can add more environment-specific variables here if needed
}
