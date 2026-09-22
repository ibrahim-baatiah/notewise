variable "name" {
  description = "The name of the Log Analytics Workspace."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Log Analytics Workspace."
  type        = string
}

variable "location" {
  description = "The Azure region in which to create the Log Analytics Workspace."
  type        = string
}

variable "subnet_id" {
    description = "The ID of the subnet in which to create the private endpoint."
    type        = string
}

variable "private_connection_resource_id" {
    description = "The ID of the resource to which the private endpoint will connect."
    type        = string
}

variable "subresource_names" {
    description = "The names of the subresources to which the private endpoint will connect."
    type        = list(string)
}

variable "virtual_network_id" {
    description = "The ID of the virtual network to which the private DNS zone will be linked."
    type        = string
}