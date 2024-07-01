# outputs.tf in Grafana module

output "grafana_endpoint" {
  value = kubernetes_service.grafana.spec[0].cluster_ip
}

output "grafana_service_name" {
  value = kubernetes_service.grafana.metadata[0].name
}

output "grafana_service_port" {
  value = kubernetes_service.grafana.spec[0].ports[0].port
}

output "grafana_deployment_name" {
  value = kubernetes_deployment.grafana.metadata[0].name
}

output "grafana_image" {
  value = kubernetes_deployment.grafana.spec[0].template[0].spec[0].containers[0].image
}

output "grafana_config_map_name" {
  value = kubernetes_config_map.grafana_config.metadata[0].name
}
