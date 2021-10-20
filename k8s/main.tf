provider "kubernetes" {
  host                   = var.k8s_properties.host
  client_certificate     = base64decode(var.k8s_properties.client_certificate)
  client_key             = base64decode(var.k8s_properties.client_key)
  cluster_ca_certificate = base64decode(var.k8s_properties.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = var.k8s_properties.host
    client_certificate     = base64decode(var.k8s_properties.client_certificate)
    client_key             = base64decode(var.k8s_properties.client_key)
    cluster_ca_certificate = base64decode(var.k8s_properties.cluster_ca_certificate)
  }
}

module "namespaces" {
  source = "./namespaces/"

  k8s_properties = var.k8s_properties
}
