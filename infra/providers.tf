# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  storage_use_azuread = true
}

terraform {
    backend "azurerm" {
        resource_group_name  = "Learning-RG"
        storage_account_name = "tfblobcontainer"
        container_name       = "terraform"
        key                  = "terraform.tfstate"
    }
}

# Configure the Microsoft Azure Provider