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
