# prometheus/main.tf

provider "kubernetes" {
  # Optionally specify a kubeconfig file. If not provided, the default kubeconfig will be used.
}

# Define Kubernetes resources for Prometheus deployment
resource "kubernetes_namespace" "prometheus" {
  metadata {
    name = "prometheus"
  }
}

resource "kubernetes_service" "prometheus" {
  metadata {
    name      = "prometheus"
    namespace = kubernetes_namespace.prometheus.metadata[0].name
    labels    = {
      app = "prometheus"
    }
  }

  spec {
    selector = {
      app = "prometheus"
    }

    port {
      name       = "web"
      port       = 9090
      target_port = 9090
    }
  }
}

resource "kubernetes_deployment" "prometheus" {
  metadata {
    name      = "prometheus"
    namespace = kubernetes_namespace.prometheus.metadata[0].name
    labels    = {
      app = "prometheus"
    }
  }

  spec {
    replicas = var.prometheus_replicas

    selector {
      match_labels = {
        app = "prometheus"
      }
    }

    template {
      metadata {
        labels = {
          app = "prometheus"
        }
      }

      spec {
        container {
          name  = "prometheus"
          image = var.prometheus_image
          port {
            container_port = 9090
          }
          args = [
            "--config.file=/etc/prometheus/prometheus.yml",
            "--storage.tsdb.retention.time=${var.prometheus_storage_retention}",
            "--web.console.templates=/etc/prometheus/consoles",
            "--web.console.libraries=/etc/prometheus/console_libraries",
          ]
          volume_mount {
            mount_path = "/etc/prometheus"
            name       = "prometheus-config"
            read_only  = true
          }
        }

        volume {
          name = "prometheus-config"
          config_map {
            name = kubernetes_config_map.prometheus_config.metadata[0].name
          }
        }
      }
    }
  }
}

# Define a ConfigMap for Prometheus configuration
resource "kubernetes_config_map" "prometheus_config" {
  metadata {
    name      = "prometheus-config"
    namespace = kubernetes_namespace.prometheus.metadata[0].name
  }

  data = {
    "prometheus.yml" = yamlencode(var.prometheus_config_data)
  }
}

# Output Prometheus endpoint
output "prometheus_endpoint" {
  value = kubernetes_service.prometheus.spec[0].cluster_ip
}
