variable "ingress_name" {
  description = "Name of the Ingress resource"
  type        = string
}

variable "namespace" {
  description = "Namespace where the Ingress will be created"
  type        = string
}

variable "hostname" {
  description = "Hostname for the Ingress resource"
  type        = string
}

variable "tls_secret_name" {
  description = "TLS secret name for the Ingress resource"
  type        = string
}

variable "service_name" {
  description = "Name of the service to route traffic to"
  type        = string
}

variable "service_port" {
  description = "Port of the service to route traffic to"
  type        = number
}
