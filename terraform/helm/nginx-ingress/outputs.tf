output "nginx_ingress_service" {
  description = "Details of the NGINX Ingress Controller Service"
  value = {
    name      = helm_release.nginx_ingress.name
    namespace = var.namespace
    ports     = [
      "HTTP: ${var.http_node_port}",
      "HTTPS: ${var.https_node_port}"
    ]
  }
}

data "kubernetes_service" "nginx_ingress_external" {
  metadata {
    name      = "nginx-ingress-controller"  # Ajusta si el nombre del servicio es diferente
    namespace = "ingress-nginx"             # Ajusta si el namespace es diferente
  }
}

output "external_ip" {
  description = "External IP of the NGINX Ingress controller"
  value       = try(
    data.kubernetes_service.nginx_ingress_external.status[0].load_balancer[0].ingress[0].ip,
    null
  )
}
