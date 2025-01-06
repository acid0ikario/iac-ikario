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
