# output "namespace" {
#   description = "Namespace creado"
#   value       = module.namespace_example.namespace_name
# }

# output "deployment_name" {
#   description = "Nombre del deployment creado"
#   value       = module.deployment_example.deployment_name
# }

# output "nginx_service_ip" {
#   description = "IP del servicio Nginx"
#   value       = module.nginx.service_ip
# }
output "nginx_external_ip" {
  description = "External IP of the NGINX Ingress controller"
  value       = module.nginx_ingress.external_ip
}
