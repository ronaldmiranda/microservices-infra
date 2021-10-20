resource "azurerm_virtual_network" "main" {
  name                = format("%s-network", local.prefix)
  address_space       = ["10.1.100.0/24"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.1.100.0/24"]
}

resource "azurerm_public_ip" "ip" {
  name                = format("%s-public-ip", local.prefix)
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "main" {
  name                = format("%s-nic", local.prefix)
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    public_ip_address_id          = azurerm_public_ip.ip.id
    private_ip_address_allocation = "Dynamic"
  }
}
