variable "ingress_name" {
  description = "Name of the ingress"
  type        = string
}

variable "namespace" {
  description = "Namespace for the ingress"
  type        = string
}

variable "hostname" {
  description = "Hostname for the ingress"
  type        = string
}

variable "tls_secret_name" {
  description = "TLS secret name"
  type        = string
}

variable "service_name" {
  description = "Name of the service to expose"
  type        = string
}

variable "service_port" {
  description = "Port of the service to expose"
  type        = number
}
