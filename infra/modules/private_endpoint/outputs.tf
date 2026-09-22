output "private_endpoint_id" {
  description = "The ID of the private endpoint."
  value       = azurerm_private_endpoint.this.id
}

output "private_dns_zone_id" {
  description = "The ID of the private DNS zone."
  value       = azurerm_private_dns_zone.this.id
}

output "private_ip_address" {
  description = "The private IP address of the private endpoint."
  value       = azurerm_private_endpoint.this.private_service_connection[0].private_ip_address
}
