variable "namespace" {
  description = "Namespace to deploy the NGINX Ingress Controller"
  type        = string
  default     = "ingress-nginx"
}

variable "service_type" {
  description = "Type of service for the ingress controller"
  type        = string
  default     = "NodePort"
}

variable "http_node_port" {
  description = "NodePort for HTTP traffic"
  type        = number
  default     = 30080
}

variable "https_node_port" {
  description = "NodePort for HTTPS traffic"
  type        = number
  default     = 30443
}
