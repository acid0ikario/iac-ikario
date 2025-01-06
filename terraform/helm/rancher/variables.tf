variable "rancher_namespace" {
  description = "Namespace where Rancher will be installed"
  default     = "cattle-system"
}

variable "rancher_hostname" {
  description = "Hostname for Rancher UI"
}

variable "rancher_replicas" {
  description = "Number of replicas for Rancher"
  default     = 3
}
