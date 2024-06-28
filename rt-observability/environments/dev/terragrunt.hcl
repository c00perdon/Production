# environments/dev/terragrunt.hcl

terraform {
  source = "terraform.io/<your_organization>/prometheus/kubernetes"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  # Variables specific to the dev environment
  prometheus_image             = "prom/prometheus:v2.30.3"
  prometheus_replicas          = 1
  prometheus_scrape_interval   = "15s"
  prometheus_storage_retention = "12h"
}
