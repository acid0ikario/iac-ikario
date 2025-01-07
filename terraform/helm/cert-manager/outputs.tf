output "cert_manager_status" {
  value = helm_release.cert_manager.status
}

output "helm_release_id" {
  description = "ID of the cert-manager helm release"
  value       = helm_release.cert_manager.id
}
