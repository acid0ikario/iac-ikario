variable "certificate_name" {
  description = "Name of the certificate resource"
  type        = string
}

variable "namespace" {
  description = "Namespace for the certificate"
  type        = string
}

variable "secret_name" {
  description = "Name of the secret to store the certificate"
  type        = string
}

variable "dns_names" {
  description = "List of DNS names for the certificate"
  type        = list(string)
}

variable "issuer_name" {
  description = "Name of the ClusterIssuer"
  type        = string
}
