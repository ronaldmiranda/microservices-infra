variable "k8s_properties" {
  type = object({
    host                   = string
    client_certificate     = string
    client_key             = string
    cluster_ca_certificate = string
    cluster_name           = string
  })
}
