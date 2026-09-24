resource "azurerm_private_dns_zone" "this" {
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                  = "${var.private_dns_zone_name}-link"
  private_dns_zone_id    = azurerm_private_dns_zone.this.id
  virtual_network_id    = var.virtual_network_id
}

resource "random_password" "this" {
  length  = 32
  special = true
}

resource "azurerm_postgresql_flexible_server" "this" {
  name                = var.server_name
  resource_group_name = var.resource_group_name
  location            = var.location
  version             = var.postgresql_version
  administrator_login = var.administrator_login
  administrator_password = random_password.this.result
  sku_name            = var.sku_name
  storage_mb          = var.storage_mb
  backup_retention_days = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled

  delegated_subnet_id = var.delegated_subnet_id

  public_network_access_enabled = var.public_network_access_enabled


}

resource "azurerm_key_vault_secret" "postgresql_admin_password" {
  name         = "postgresql-admin-password"
  value        = random_password.this.result
  key_vault_id = var.key_vault_id
}

resource "azurerm_postgresql_flexible_server_database" "this" {
  name                = var.database_name
  server_id         = azurerm_postgresql_flexible_server.this.id
}