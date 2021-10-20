output "k8s_properties" {
  value = {
    host                   = azurerm_kubernetes_cluster.k8s.kube_config.0.host
    client_certificate     = azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate
    client_key             = azurerm_kubernetes_cluster.k8s.kube_config.0.client_key
    cluster_ca_certificate = azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate
    cluster_name           = azurerm_kubernetes_cluster.k8s.name
  }
}
