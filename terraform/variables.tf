# Variables globales para Terraform
variable "namespace_name" {
  description = "Nombre del namespace"
  type        = string
  default     = "nginx-namespace"
}

variable "replicas" {
  description = "Número de réplicas del deployment"
  type        = number
  default     = 1
}

variable "nginx_replicas" {
  description = "Número de réplicas para Nginx"
  type        = number
  default     = 3
}

variable "nginx_service_type" {
  description = "Tipo de servicio para Nginx"
  type        = string
  default     = "NodePort"
}

variable "email" {
  description = "email"
  type        = string
  default     = "1mm.villanueva1@gmail.com"
}