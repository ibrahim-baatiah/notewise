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

# Wiring up the Key Vault module
module "key_vault" {
    source = "./modules/key_vault"
    vault_name = "notewise-kv"
    resource_group_name = azurerm_resource_group.notewise.name
    location = var.location
    sku_name = "standard"
    rbac_auth_enabled = true
    purge_protection_enabled = true
    soft_delete_retention_days = 90
    public_network_access_enabled = false
}

module "private_endpoint" {
    source = "./modules/private_endpoint"

    name = "privatelink.vaultcore.azure.net"
    resource_group_name = azurerm_resource_group.notewise.name
    location = var.location
    subnet_id = module.network.subnet_ids["snet-pe"]
    private_connection_resource_id = module.key_vault.vault_id
    subresource_names = ["vault"]
    virtual_network_id = module.network.vnet_id
}

module "postgresql_server" {
    source = "./modules/postgresql_server"

    server_name = "notewise-server-db"
    resource_group_name = azurerm_resource_group.notewise.name
    location = var.location
    private_dns_zone_name = "privatelink.postgres.database.azure.com"
    virtual_network_id = module.network.vnet_id
    postgresql_version = "16"
    sku_name = "B_Standard_B1ms"
    storage_mb = 32768
    backup_retention_days = 7
    geo_redundant_backup_enabled = false
    delegated_subnet_id = module.network.subnet_ids["snet-db"]
    key_vault_id = module.key_vault.vault_id
}