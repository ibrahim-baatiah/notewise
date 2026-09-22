resource "azurerm_private_dns_zone" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                  = "${var.name}-link"
  private_dns_zone_id    = azurerm_private_dns_zone.this.id
  virtual_network_id    = var.virtual_network_id
}

resource "azurerm_private_endpoint" "this" {
    name = var.name
    resource_group_name = var.resource_group_name
    location = var.location
    subnet_id = var.subnet_id

    private_service_connection {
        name = "${var.name}-connection"
        private_connection_resource_id = var.private_connection_resource_id
        subresource_names = var.subresource_names
        is_manual_connection = false
    }

    private_dns_zone_group {
        name = "${var.name}-dns-zone-group"
        private_dns_zone_ids = [azurerm_private_dns_zone.this.id]
    }
}