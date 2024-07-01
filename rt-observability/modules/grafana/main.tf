# grafana/main.tf

provider "kubernetes" {
  host        = "https://127.0.0.1:62032"
  insecure    = true
}

# Define Kubernetes resources for Grafana deployment
resource "kubernetes_namespace" "grafana" {
  metadata {
    name = "grafana"
  }
}

resource "kubernetes_service" "grafana" {
  metadata {
    name      = "grafana"
    namespace = kubernetes_namespace.grafana.metadata[0].name
    labels    = {
      app = "grafana"
    }
  }

  spec {
    selector = {
      app = "grafana"
    }

    port {
      name       = "web"
      port       = 3000
      target_port = 3000
    }
  }
}

resource "kubernetes_deployment" "grafana" {
  metadata {
    name      = "grafana"
    namespace = kubernetes_namespace.grafana.metadata[0].name
    labels    = {
      app = "grafana"
    }
  }

  spec {
    replicas = var.grafana_replicas

    selector {
      match_labels = {
        app = "grafana"
      }
    }

    template {
      metadata {
        labels = {
          app = "grafana"
        }
      }

      spec {
        container {
          name  = "grafana"
          image = var.grafana_image
          env {
            name  = "GF_SECURITY_ADMIN_USER"
            value = var.grafana_admin_user
          }
          env {
            name  = "GF_SECURITY_ADMIN_PASSWORD"
            value = var.grafana_admin_password
          }
          port {
            container_port = 3000
          }
        }
      }
    }
  }
}

# Define a ConfigMap for Grafana configuration
resource "kubernetes_config_map" "grafana_config" {
  metadata {
    name      = "grafana-config"
    namespace = kubernetes_namespace.grafana.metadata[0].name
  }

  data = {
    "grafana.ini" = <<EOF
[paths]
data = /var/lib/grafana/data
logs = /var/log/grafana
plugins = /var/lib/grafana/plugins
provisioning = /etc/grafana/provisioning

[server]
http_port = 3000

[database]
type = sqlite3
path = grafana.db

[security]
admin_user = ${var.grafana_admin_user}
admin_password = ${var.grafana_admin_password}

[provisioning]
enabled = true
EOF
  }
}

# Output Grafana endpoint
output "grafana_endpoint" {
  value = kubernetes_service.grafana.spec[0].cluster_ip
}
