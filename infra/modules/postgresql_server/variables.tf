variable "server_name" {
  description = "The name of the PostgreSQL flexible server."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the PostgreSQL flexible server."
  type        = string
}

variable "location" {
  description = "The Azure region in which to create the PostgreSQL flexible server."
  type        = string
}

variable "private_dns_zone_name" {
  description = "The name of the private DNS zone to create."
  type        = string
}

variable "virtual_network_id" {
  description = "The ID of the virtual network to which the private DNS zone will be linked."
  type        = string
}

variable "postgresql_version" {
  description = "The version of PostgreSQL to use for the flexible server."
  type        = string
}

variable "administrator_login" {
  description = "The administrator login name for the PostgreSQL flexible server."
  type        = string
  default     = "notewiseadmin"
}

variable "sku_name" {
  description = "The SKU name for the PostgreSQL flexible server."
  type        = string
}

variable "storage_mb" {
  description = "The storage size in MB for the PostgreSQL flexible server."
  type        = number
}

variable "backup_retention_days" {
  description = "The number of days to retain backups for the PostgreSQL flexible server."
  type        = number
}

variable "geo_redundant_backup_enabled" {
  description = "Whether geo-redundant backups are enabled for the PostgreSQL flexible server."
  type        = bool
}


variable "delegated_subnet_id" {
  description = "The ID of the subnet to which the PostgreSQL flexible server will be delegated."
  type        = string
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled for the PostgreSQL flexible server."
  type        = bool
  default     = false
}

variable "key_vault_id" {
  description = "The ID of the Key Vault where the PostgreSQL administrator password will be stored."
  type        = string
}

variable "database_name" {
  description = "The name of the PostgreSQL database to create."
  type        = string
  default     = "notewise"
}