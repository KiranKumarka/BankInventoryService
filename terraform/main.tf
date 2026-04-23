# ============================================================
# BankInventoryService — Terraform Infrastructure
# Creates: Resource Group, App Service Plan, App Services
#          for Dev, Staging, and Prod environments
# ============================================================

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  # TODO: Enable this backend when you have Azure Storage Account for state
  # backend "azurerm" {
  #   resource_group_name  = "tfstate-rg"
  #   storage_account_name = "bankinvtfstate"
  #   container_name       = "tfstate"
  #   key                  = "bankinventory.tfstate"
  # }
}

provider "azurerm" {
  features {}
  subscription_id = "1d566dda-fe8b-4b7a-a15e-7c4f64f3e1d5"
  use_cli         = true
}