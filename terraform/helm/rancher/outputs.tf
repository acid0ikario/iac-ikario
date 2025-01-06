output "rancher_ui_url" {
  description = "URL for Rancher UI"
  value       = "https://${var.rancher_hostname}"
}
