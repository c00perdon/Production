# grafana/outputs.tf

output "grafana_service_name" {
  value = kubernetes_service.grafana.metadata[0].name
}

output "grafana_service_port" {
  value = kubernetes_service.grafana.spec[0].port[0].port
}

output "grafana_service_cluster_ip" {
  value = kubernetes_service.grafana.spec[0].cluster_ip
}

output "grafana_deployment_name" {
  value = kubernetes_deployment.grafana.metadata[0].name
}

output "grafana_image" {
  value = kubernetes_deployment.grafana.spec[0].template[0].spec[0].container[0].image
}

output "grafana_admin_user" {
  value = var.grafana_admin_user
}

output "grafana_admin_password" {
  value = var.grafana_admin_password
}
