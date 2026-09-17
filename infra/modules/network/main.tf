resource "azurerm_virtual_network" "this" {
    name                = var.vnet_name
    address_space       = var.vnet_address_space
    location            = var.location
    resource_group_name = var.resource_group_name   
}

resource "azurerm_subnet" "this" {
    for_each = var.subnets

    name                 = each.key
    resource_group_name  = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.this.name
    address_prefixes     = each.value.address_prefix

    dynamic "delegation" {
        for_each = each.value.delegation != null ? [each.value.delegation] : []
        content {
        name = "delegation"
        service_delegation {
            name    = delegation.value
            actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        }
        }
    }
}

resource "azurerm_network_security_group" "this" {
    for_each = {for k, v in var.subnets : k => v if v.create_nsg }

    name = "nsg-${each.key}"
    location            = var.location
    resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "this" {
    for_each = azurerm_network_security_group.this

    subnet_id = azurerm_subnet.this[each.key].id
    network_security_group_id = each.value.id
}