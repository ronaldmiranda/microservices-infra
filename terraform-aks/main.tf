provider "azurerm" {
  features {}
  subscription_id = "1e9a7074-949c-4cd7-81cd-83a5adf51a05"
}

data "azurerm_subscription" "default" {}

module "name" {
  source              = "./aks"
  resource_group_name = "tcc-aks-rg"
  prefix              = "tcc-cluster"
  location            = "westus2"
  tags                = {}
}

module "k8s" {
  source = "./k8s"

  k8s_properties = module.name.k8s_properties
}
