# Módulo para crear el namespace "cattle-system"
# Este namespace será usado por Rancher y Cert-Manager para organizar sus recursos
module "namespace" {
  source          = "./modules/namespace"
  namespace_name  = "cattle-system"  # Nombre del namespace
}

# Módulo para instalar el controlador de Ingress NGINX
# Este controlador permite gestionar el tráfico externo hacia los servicios del clúster
module "nginx_ingress" {
  source = "./helm/nginx-ingress"

  # Aseguramos que el namespace esté creado antes de instalar el controlador de Ingress
  depends_on = [module.namespace]
}

# Módulo para instalar Cert-Manager
# Cert-Manager se encarga de gestionar certificados TLS automáticamente
module "cert_manager" {
  source = "./helm/cert-manager"

  # Aseguramos que el namespace esté creado antes de instalar Cert-Manager
  depends_on = [module.namespace]
}

# Módulo para instalar Rancher
# Rancher proporciona una interfaz gráfica para gestionar el clúster Kubernetes
module "rancher" {
  source            = "./helm/rancher"

  # Configuración del namespace y otros parámetros de Rancher
  rancher_namespace = "cattle-system"              # Namespace donde se instalará Rancher
  rancher_hostname  = "rancher.my-cluster.local"   # Hostname para acceder a Rancher
  rancher_replicas  = 3                            # Número de réplicas del servicio Rancher

  # Aseguramos que Cert-Manager esté instalado antes de instalar Rancher
  depends_on = [module.cert_manager]
}

# Módulo para crear el recurso Ingress
# Este Ingress expone el servicio Rancher al exterior
module "ingress" {
  source          = "./modules/ingress"
  ingress_name    = "rancher-ingress"
  namespace       = "cattle-system"
  hostname        = "rancher.my-cluster.local"
  tls_secret_name = "tls-secret"
  service_name    = "rancher"
  service_port    = 80

  depends_on = [module.rancher]
}
