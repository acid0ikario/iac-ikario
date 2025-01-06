resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = var.namespace

  create_namespace = true

  values = [file("${path.module}/values.yaml")]

  set {
    name  = "controller.service.type"
    value = var.service_type
  }

  set {
    name  = "controller.service.nodePorts.http"
    value = var.http_node_port
  }

  set {
    name  = "controller.service.nodePorts.https"
    value = var.https_node_port
  }
}

data "kubernetes_service" "nginx_ingress" {
  metadata {
    name      = "nginx-ingress-controller"  # Ajusta el nombre del servicio según tu configuración
    namespace = var.namespace            # Ajusta el namespace según sea necesario
  }
}
