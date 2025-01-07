resource "kubernetes_manifest" "tls_certificate" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "Certificate"
    metadata = {
      name      = var.certificate_name
      namespace = var.namespace
    }
    spec = {
      secretName = var.secret_name
      dnsNames   = var.dns_names
      issuerRef = {
        name = var.issuer_name
        kind = "ClusterIssuer"
      }
    }
  }
}
