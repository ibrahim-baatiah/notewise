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

    vnet_name = "notewise-vnet"
    vnet_address_space = ["10.0.0.0/16"]
    resource_group_name = azurerm_resource_group.notewise.name
    location = var.location

    subnets = {
        snet-aks = {
            address_prefix = ["10.0.0.0/22"],
            create_nsg = false
        }
        snet-db = {
            address_prefix = ["10.0.4.0/24"],
            delegation = "Microsoft.DBforPostgreSQL/flexibleServers"
        }
        snet-pe = {
            address_prefix = ["10.0.5.0/24"]
        }
    }
}

module "log_analytics_workspace" {
    source = "./modules/log_analytics_workspace"

    name = "notewise-law"
    location = var.location
    resource_group_name = azurerm_resource_group.notewise.name
    sku = "PerGB2018"
    retention_in_days = 30
}

module "acr" {
    source = "./modules/acr"

    acr_name = "notewiseacr01"
    resource_group_name = azurerm_resource_group.notewise.name
    location = var.location
    sku = "Basic"
    admin_enabled = false
    georeplications = []
    zone_redundancy_enabled = false
}

# Run Terraform Infra Pipeline