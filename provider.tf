terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.ARM_subscription_id
  client_id       = var.ARM_client_id
  client_secret   = var.ARM_client_secret
  tenant_id       = var.ARM_tenant_id
}
