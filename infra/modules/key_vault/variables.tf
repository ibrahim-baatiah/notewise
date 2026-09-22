variable "vault_name" {
  type        = string
  description = "The name of the key vault to be created. The value will be randomly generated if blank."
  default     = ""
}

variable "location" {
  type        = string
  description = "The location of the key vault to be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which the key vault will be created."
}

variable "key_name" {
  type        = string
  description = "The name of the key to be created. The value will be randomly generated if blank."
  default     = ""
}

variable "sku_name" {
  type        = string
  description = "The SKU of the vault to be created."
  default     = "standard"
  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "The sku_name must be one of the following: standard, premium."
  }
}

variable "key_permissions" {
  type        = list(string)
  description = "List of key permissions."
  default     = ["List", "Create", "Delete", "Get", "Purge", "Recover", "Update", "GetRotationPolicy", "SetRotationPolicy"]
}

variable "secret_permissions" {
  type        = list(string)
  description = "List of secret permissions."
  default     = ["Set"]
}

variable "rbac_auth_enabled" {
    type = bool
    description = "Enable RBAC authorization for the key vault."
    default = true
}

variable "purge_protection_enabled" {
    type = bool
    description = "Enable purge protection for the key vault."
    default = true
}

variable "soft_delete_retention_days" {
    type = number
    description = "The number of days to retain deleted secrets and keys in the key vault."
    default = 90
}

variable "public_network_access_enabled" {
    type = bool
    description = "Enable public network access for the key vault."
    default = false
}