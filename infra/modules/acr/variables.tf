variable "acr_name" {
  description = "The name of the Azure Container Registry."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Azure Container Registry."
  type        = string
}

variable "location" {
  description = "The Azure region in which to create the Azure Container Registry."
  type        = string
}

variable "sku" {
  description = "The SKU of the Azure Container Registry. Possible values are 'Basic', 'Standard', and 'Premium'."
  type        = string
  default     = "Basic"
}

variable "admin_enabled" {
  description = "Whether to enable the admin user for the Azure Container Registry."
  type        = bool
  default     = false
}

variable "georeplications" {
  description = "A list of georeplication locations for the Azure Container Registry."
  type        = list(string)
  default     = []
}

variable "zone_redundancy_enabled" {
  description = "Whether to enable zone redundancy for the Azure Container Registry."
  type        = bool
  default     = false
}