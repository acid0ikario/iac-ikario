resource "helm_release" "nginx" {
  name       = "nginx"
  chart      = "https://charts.bitnami.com/bitnami/nginx-18.3.2.tgz"

  values = [file("${path.module}/values.yaml")]

  set {
    name  = "replicaCount"
    value = var.nginx_replicas
  }

  set {
    name  = "service.type"
    value = var.nginx_service_type
  }
}
