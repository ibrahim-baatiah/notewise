output "vnet_id" {
  value = module.network.vnet_id
}

output "subnet_ids" {
  value = module.network.subnet_ids
}

output "log_analytics_workspace_id" {
  value = module.log_analytics_workspace.log_analytics_workspace_id
}

output "acr_id" {
  value = module.acr.acr_id
}

output "acr_login_server" {
  value = module.acr.acr_login_server
}

output "key_vault_id" {
  value = module.key_vault.vault_id
}

output "key_vault_uri" {
  value = module.key_vault.vault_uri
}

output "postgresql_server_fqdn" {
  value = module.postgresql_server.server_fqdn
}