#!/bin/bash

# Define el nombre del proyecto
PROJECT_NAME="terraform"

echo "Creando la estructura del proyecto Terraform para Kubernetes en '$PROJECT_NAME'..."

# Crear la estructura de directorios
mkdir -p $PROJECT_NAME/{modules/{namespace,deployment,service},helm/{nginx,cert-manager},envs/{dev,staging,production}}

# Crear archivos principales
cat > $PROJECT_NAME/main.tf <<EOF
# Archivo principal de Terraform
# Incluye la configuración de los módulos y Helm Charts

module "namespace_example" {
  source = "./modules/namespace"
  namespace_name = "example-namespace"
}

module "deployment_example" {
  source = "./modules/deployment"
  namespace = module.namespace_example.namespace_name
  deployment_name = "example-deployment"
  image = "nginx:1.19.10"
  replicas = 2
}

module "nginx" {
  source = "./helm/nginx"
}
EOF

cat > $PROJECT_NAME/variables.tf <<EOF
# Variables globales para Terraform
variable "namespace_name" {
  description = "Nombre del namespace"
  type        = string
  default     = "default"
}

variable "replicas" {
  description = "Número de réplicas del deployment"
  type        = number
  default     = 1
}

variable "nginx_replicas" {
  description = "Número de réplicas para Nginx"
  type        = number
  default     = 2
}

variable "nginx_service_type" {
  description = "Tipo de servicio para Nginx"
  type        = string
  default     = "LoadBalancer"
}
EOF

cat > $PROJECT_NAME/provider.tf <<EOF
# Configuración del proveedor Kubernetes y Helm
provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
EOF

cat > $PROJECT_NAME/outputs.tf <<EOF
# Definición de salidas útiles
output "namespace" {
  description = "Namespace creado"
  value       = module.namespace_example.namespace_name
}

output "deployment_name" {
  description = "Nombre del deployment creado"
  value       = module.deployment_example.deployment_name
}

output "nginx_service_ip" {
  description = "IP del servicio Nginx"
  value       = helm_release.nginx.status[0].load_balancer.ingress[0].ip
}
EOF

cat > $PROJECT_NAME/.gitignore <<EOF
# Ignorar archivos sensibles
.terraform/
terraform.tfstate
terraform.tfstate.backup
EOF

# Crear módulo para namespaces
cat > $PROJECT_NAME/modules/namespace/main.tf <<EOF
resource "kubernetes_namespace" "this" {
  metadata {
    name = var.namespace_name
  }
}
EOF

cat > $PROJECT_NAME/modules/namespace/variables.tf <<EOF
variable "namespace_name" {
  description = "Nombre del namespace"
  type        = string
}
EOF

cat > $PROJECT_NAME/modules/namespace/outputs.tf <<EOF
output "namespace_name" {
  value = kubernetes_namespace.this.metadata[0].name
}
EOF

# Crear módulo para Helm (Nginx)
cat > $PROJECT_NAME/helm/nginx/helm.tf <<EOF
resource "helm_release" "nginx" {
  name       = "nginx"
  chart      = "bitnami/nginx"
  repository = "https://charts.bitnami.com/bitnami"
  version    = "13.2.19"

  values = [file("${path.module}/values.yaml")]

  set {
    name  = "replicaCount"
    value = var.nginx_replicas
  }

  set {
    name  = "service.type"
    value = var.nginx_service_type
  }
}
EOF

cat > $PROJECT_NAME/helm/nginx/values.yaml <<EOF
replicaCount: 2
service:
  type: LoadBalancer
  port: 80
EOF

cat > $PROJECT_NAME/helm/nginx/variables.tf <<EOF
variable "nginx_replicas" {
  description = "Número de réplicas para Nginx"
  type        = number
}

variable "nginx_service_type" {
  description = "Tipo de servicio para Nginx"
  type        = string
}
EOF

# Mensaje de finalización
echo "Estructura creada exitosamente en '$PROJECT_NAME/'."
