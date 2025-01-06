resource "helm_release" "rancher" {
  name       = "rancher"
  chart      = "rancher"
  repository = "https://releases.rancher.com/server-charts/stable"
  namespace  = var.rancher_namespace

  values = [file("${path.module}/values.yaml")]

  set {
    name  = "hostname"
    value = var.rancher_hostname
  }

  set {
    name  = "replicas"
    value = var.rancher_replicas
  }

  set {
    name  = "ingress.tls.source"
    value = "letsEncrypt"
  }
}
