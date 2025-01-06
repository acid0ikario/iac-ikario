variable "service_name" {
  description = "Nombre del servicio"
  type        = string
}

variable "namespace" {
  description = "Namespace del servicio"
  type        = string
}

variable "selector" {
  description = "Selector del servicio"
  type        = string
}

variable "port" {
  description = "Puerto del servicio"
  type        = number
}

variable "target_port" {
  description = "Puerto objetivo del servicio"
  type        = number
}
