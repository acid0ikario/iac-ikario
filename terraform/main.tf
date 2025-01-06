module "namespace" {
  source = "./modules/namespace"
  namespace_name = "cattle-system"
}

module "nginx_ingress" {
  source = "./helm/nginx-ingress"
}

module "cert_manager" {
  source = "./helm/cert-manager"
}

module "rancher" {
  source = "./helm/rancher"

  rancher_namespace = "cattle-system"
  rancher_hostname  = "rancher.my-cluster.local"
  rancher_replicas  = 3
}

module "ingress" {
  source          = "./modules/ingress"
  ingress_name    = "rancher-ingress"
  namespace       = "cattle-system"
  hostname        = "rancher.my-cluster.local"
  tls_secret_name = "tls-secret"
  service_name    = "rancher"
  service_port    = 80
}
