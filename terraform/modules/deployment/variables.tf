variable "deployment_name" {
  description = "Nombre del deployment"
  type        = string
}

variable "namespace" {
  description = "Namespace del deployment"
  type        = string
}

variable "image" {
  description = "Imagen del contenedor"
  type        = string
}

variable "replicas" {
  description = "Número de réplicas"
  type        = number
  default     = 1
}
