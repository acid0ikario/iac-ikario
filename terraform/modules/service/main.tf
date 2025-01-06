resource "kubernetes_service" "this" {
  metadata {
    name      = var.service_name
    namespace = var.namespace
  }
  spec {
    selector = {
      app = var.selector
    }
    port {
      port        = var.port
      target_port = var.target_port
    }
  }
}
