# module "namespace" {
#   source = "./modules/namespace"
#   namespace_name = var.namespace_name
# }

# module "deployment" {
#   source = "./modules/deployment"
#   namespace = module.namespace.namespace_name
#   deployment_name = "example-deployment"
#   image = "nginx:1.19.10"
#   replicas = var.replicas
# }

module "nginx" {
  source = "./helm/nginx"
  nginx_service_type = "ClusterIP"
  nginx_replicas = var.nginx_replicas
}