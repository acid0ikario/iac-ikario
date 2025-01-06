output "ingress_hostname" {
  description = "Hostname of the Ingress resource"
  value       = kubernetes_ingress_v1.rancher_ingress.spec[0].rule[0].host
}
