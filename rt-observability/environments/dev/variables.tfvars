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
