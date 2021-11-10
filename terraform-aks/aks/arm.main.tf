resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                      = format("%s-k8s", var.prefix)
  location                  = var.location
  resource_group_name       = azurerm_resource_group.rg.name
  kubernetes_version        = "1.20.9"
  dns_prefix                = var.prefix
  automatic_channel_upgrade = "node-image"
  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }

  default_node_pool {
    name            = "nodeapp"
    node_count      = "2"
    type            = "AvailabilitySet"
    vm_size         = "Standard_DS2_v2"
    os_disk_size_gb = "50"
    vnet_subnet_id  = azurerm_subnet.snet01.id
  }

  service_principal {
    client_id     = azuread_application.aks.application_id
    client_secret = azuread_service_principal_password.aks.value
  }

  tags = var.tags
}
