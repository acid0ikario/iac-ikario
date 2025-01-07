resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = var.namespace
  timeout    = 600
  create_namespace = true

  values = [file("${path.module}/values.yaml")]

  set {
    name  = "controller.service.type"
    value = var.service_type
  }
    # Asignamos explícitamente los NodePorts que coinciden con los "containerPort" de Kind:
  set {
    name  = "controller.service.nodePorts.http"
    value = "30080"
  }
  set {
    name  = "controller.service.nodePorts.https"
    value = "30443"
  }
}

data "kubernetes_service" "nginx_ingress" {
  metadata {
    name      = "nginx-ingress-controller"  # Ajusta el nombre del servicio según tu configuración
    namespace = var.namespace            # Ajusta el namespace según sea necesario
  }
}
