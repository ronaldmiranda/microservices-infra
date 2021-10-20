variable "k8s_properties" {
  type = object({
    host                   = string
    client_certificate     = string
    client_key             = string
    cluster_ca_certificate = string
    cluster_name           = string
  })
}

locals {

  default_labels = merge(
    {
      cluster_name = var.k8s_properties.cluster_name,
      provider     = "terraform.io",
    }
  )

  namespace_labels = merge(local.default_labels)
}
