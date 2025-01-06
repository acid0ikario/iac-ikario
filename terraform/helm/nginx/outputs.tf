# output "namespace" {
#   description = "Namespace creado"
#   value       = module.namespace_example.namespace_name
# }

# output "deployment_name" {
#   description = "Nombre del deployment creado"
#   value       = module.deployment_example.deployment_name
# }

output "service_ip" {
  description = "IP del servicio Nginx"
  value       = try(helm_release.nginx.status, "No IP disponible")
}
