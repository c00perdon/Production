# prometheus/outputs.tf

output "prometheus_service_name" {
  value = kubernetes_service.prometheus.metadata[0].name
}

output "prometheus_service_port" {
  value = kubernetes_service.prometheus.spec[0].ports[0].port
}

output "prometheus_service_cluster_ip" {
  value = kubernetes_service.prometheus.spec[0].cluster_ip
}

output "prometheus_deployment_name" {
  value = kubernetes_deployment.prometheus.metadata[0].name
}

output "prometheus_image" {
  value = kubernetes_deployment.prometheus.spec[0].template.spec[0].container[0].image
}

output "prometheus_config_map_name" {
  value = kubernetes_config_map.prometheus_config.metadata[0].name
}
