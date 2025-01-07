###################################
# Namespace para Rancher
###################################
module "namespace" {
  source         = "./modules/namespace"
  namespace_name = "cattle-system"
}

###################################
# NGINX Ingress
###################################
module "nginx_ingress" {
  source     = "./helm/nginx-ingress"
  depends_on = [module.namespace]
}

###################################
# Cert-Manager
###################################
module "cert_manager" {
  source = "./helm/cert-manager"
  # Podrías usar variables si quieres, pero con los defaults está bien.
}

resource "null_resource" "wait_for_cert_manager_crds" {
  depends_on = [
    module.cert_manager.helm_release_id
  ]

  provisioner "local-exec" {
    command = <<-EOT
      echo "Esperando a que los CRDs de cert-manager se registren..."
      for i in {1..20}; do
        # Revisa uno de los CRDs, por ejemplo clusterissuers.cert-manager.io
        if kubectl get crd clusterissuers.cert-manager.io &>/dev/null; then
          echo "CRDs de cert-manager encontrados."
          exit 0
        fi
        echo "CRDs aún no disponibles, durmiendo 5s..."
        sleep 5
      done
      echo "ERROR: Se agotó el tiempo esperando CRDs de cert-manager."
      exit 1
    EOT
  }
}


###################################
# Cluster Issuer
###################################
module "cluster_issuer" {
  source                  = "./modules/cluster_issuer"
  namespace               = "cert-manager"
  email                   = var.email
  private_key_secret_name = "letsencrypt-production"
  ingress_class           = "nginx"
  issuer_name             = "letsencrypt-production"

  depends_on = [
    module.cert_manager.helm_release_id,
    null_resource.wait_for_cert_manager_crds
  ]
}


###################################
# Certificado TLS
###################################
module "tls_certificate" {
  source           = "./modules/certificate"
  certificate_name = "tls-secret"
  namespace        = "cattle-system"
  secret_name      = "tls-secret"
  dns_names        = ["rancher.my-cluster.local"]
  issuer_name      = module.cluster_issuer.cluster_issuer_name

  # Primero, cluster_issuer (y por ende cert_manager)
  depends_on = [module.cluster_issuer]
}

###################################
# Rancher
###################################
module "rancher" {
  source            = "./helm/rancher"
  rancher_namespace = "cattle-system"
  rancher_hostname  = "rancher.my-cluster.local"
  rancher_replicas  = 3

  # Espera a que el TLS esté listo
  depends_on = [module.tls_certificate]
}

###################################
# Ingress para Rancher
###################################
module "ingress" {
  source          = "./modules/ingress"
  ingress_name    = "rancher-ingress"
  namespace       = "cattle-system"
  hostname        = "rancher.my-cluster.local"
  tls_secret_name = module.tls_certificate.certificate_secret_name
  service_name    = "rancher"
  service_port    = 80

  depends_on = [module.rancher]
}
