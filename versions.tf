terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.6.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.3.2"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.2.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "2.21.0"
    }
  }
  backend "azurerm" {
    subscription_id      = "1e9a7074-949c-4cd7-81cd-83a5adf51a05"
    resource_group_name  = "terradorm-storage"
    storage_account_name = "tccinfrastates"
    container_name       = "states"
    key                  = "tcc/terraform.tfstate"
  }
}
