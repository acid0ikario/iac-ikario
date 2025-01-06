resource "kubernetes_deployment" "this" {
  metadata {
    name      = var.deployment_name
    namespace = var.namespace
  }
  spec {
    replicas = var.replicas
    selector {
      match_labels = {
        app = var.deployment_name
      }
    }
    template {
      metadata {
        labels = {
          app = var.deployment_name
        }
      }
      spec {
        container {
          name  = var.deployment_name
          image = var.image
        }
      }
    }
  }
}
