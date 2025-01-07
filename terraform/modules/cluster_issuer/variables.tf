variable "namespace" {
  description = "Namespace where the ClusterIssuer will be created"
  type        = string
}

variable "email" {
  description = "Email address for ACME registration"
  type        = string
}

variable "private_key_secret_name" {
  description = "Name of the secret for the private key"
  type        = string
}

variable "ingress_class" {
  description = "Ingress class to use for HTTP01 challenges"
  type        = string
}

variable "issuer_name" {
  description = "Name of the cluster issuer"
  type        = string
}
