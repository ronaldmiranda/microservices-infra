provider "azurerm" {
  features {}
  subscription_id = "1e9a7074-949c-4cd7-81cd-83a5adf51a05"
}

data "azurerm_subscription" "current" {}

resource "azurerm_resource_group" "main" {
  name     = format("%s-resources", local.prefix)
  location = "West Europe"
}
resource "tls_private_key" "key" {
  algorithm = "RSA"
}

resource "azurerm_virtual_machine" "main" {
  name                  = format("%s-vm", local.prefix)
  location              = azurerm_resource_group.main.location
  resource_group_name   = azurerm_resource_group.main.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "jenkins-vm"
    admin_username = var.vm_username
    custom_data    = file("./cloudinit")
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/${var.vm_username}/.ssh/authorized_keys"
      key_data = tls_private_key.key.public_key_openssh
    }
  }
  tags = {
    environment = "staging"
  }
}

output "privatekey" {
  value     = tls_private_key.key.private_key_pem
  sensitive = true
}
