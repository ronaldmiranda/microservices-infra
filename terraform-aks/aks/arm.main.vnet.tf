resource "azurerm_virtual_network" "vnet" {
  name                = format("%s-vnet", var.prefix)
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.27.0.0/16"]
  tags                = azurerm_resource_group.rg.tags
}

resource "azurerm_subnet" "snet01" {
  name                 = format("%s-snet01", var.prefix)
  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.27.0.0/21"]
  depends_on           = [azurerm_virtual_network.vnet]
}

resource "azurerm_subnet" "snet02" {
  name                 = format("%s-snet02", var.prefix)
  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.27.8.0/21"]
  depends_on           = [azurerm_virtual_network.vnet]
}
