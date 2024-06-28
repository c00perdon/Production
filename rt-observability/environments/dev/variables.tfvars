# environments/dev/variables.tfvars

# Example variables for dev environment
prometheus_image = "prom/prometheus:v2.30.3"
prometheus_replicas = 1
prometheus_scrape_interval = "15s"
prometheus_storage_retention = "12h"

# Add more variables as needed
