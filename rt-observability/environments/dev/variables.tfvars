# Prometheus variables
prometheus_image             = "prom/prometheus:v2.30.3"
prometheus_replicas          = 1
prometheus_scrape_interval   = "15s"
prometheus_storage_retention = "12h"

prometheus_config_data = {
  global = {
    scrape_interval = "15s"
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

# Grafana variables
grafana_image       = "grafana/grafana:latest"
grafana_replicas    = 1
grafana_admin_user  = "admin"
grafana_admin_password = "admin_password"

# Grafana configuration data (example structure)
grafana_config_data = {
  datasources = {
    apiVersion = 1
    datasources = [
      {
        name = "Prometheus"
        type = "prometheus"
        url  = "http://prometheus-service:9090"
        access = "proxy"
        isDefault = true
      }
    ]
  }
  dashboards = [
    {
      name = "Example Dashboard"
      json = file("path/to/dashboard.json")
    }
  ]
}
