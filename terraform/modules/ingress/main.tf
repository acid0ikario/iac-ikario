resource "kubernetes_ingress_v1" "default" {
  metadata {
    name      = var.ingress_name
    namespace = var.namespace
    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = "/"
    }
  }

  spec {
    tls {
      hosts      = [var.hostname]
      secret_name = var.tls_secret_name
    }

    rule {
      host = var.hostname

      http {
        path {
          path     = "/"
          path_type = "Prefix"

          backend {
            service {
              name = var.service_name
              port {
                number = var.service_port
              }
            }
          }
        }
      }
    }
  }
}