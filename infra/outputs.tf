output "vnet_id" {
  value = module.network.vnet_id
}

output "subnet_ids" {
  value = module.network.subnet_ids
}

output "log_analytics_workspace_id" {
  value = module.log_analytics_workspace.log_analytics_workspace_id
}