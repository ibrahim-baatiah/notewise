terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.0.0"
    }
  }
}

resource "azurerm_resource_group" "notewise" {
    name = "notewise"
    location = var.location
}

module "network" {
    source = "./modules/network"

    vnet_name = "notewuse-vnet"
    vnet_address_space = ["10.0.0.0/16"]
    resource_group_name = azurerm_resource_group.notewise.name
    location = var.location
}