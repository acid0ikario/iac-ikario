resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  namespace        = "cert-manager"
  version          = "v1.13.0"
  create_namespace = true
  values = [file("${path.module}/values.yaml")]
  set {
    name  = "installCRDs"
    value = "true"
  }
}
