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

grafana_image       = "grafana/grafana:9.0.7"
grafana_replicas    = 1
grafana_admin_user  = "admin"
grafana_admin_password = "admin"
grafana_config_data = {
  server = {
    http_port = 3000
  }
  security = {
    admin_user     = "admin"
    admin_password = "admin"
  }
}