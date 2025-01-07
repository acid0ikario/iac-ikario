output "certificate_secret_name" {
  value = kubernetes_manifest.tls_certificate.manifest.spec.secretName
}

output "secret_name" {
  description = "Name of the TLS secret generated by the Certificate"
  value       = var.secret_name
}
