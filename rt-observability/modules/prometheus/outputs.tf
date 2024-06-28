output "prometheus_service_name" {
  value = kubernetes_service.prometheus.metadata.name
}

output "prometheus_service_port" {
  value = kubernetes_service.prometheus.spec.ports[0].port
}

output "prometheus_service_cluster_ip" {
  value = kubernetes_service.prometheus.spec.cluster_ip
}

output "prometheus_deployment_name" {
  value = kubernetes_deployment.prometheus.metadata.name
}

output "prometheus_image" {
  value = kubernetes_deployment.prometheus.spec.template.spec.container[0].image
}

output "prometheus_config_map_name" {
  value = kubernetes_config_map.prometheus_config.metadata.name
}
