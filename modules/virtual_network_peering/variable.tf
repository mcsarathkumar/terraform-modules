variable "peering_name" {
  type        = string
  description = "Name of the Peering"
}

variable "virtual_network_name" {
  type        = string
  description = "Location of the Virtual Network"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "remote_virtual_network_id" {
  type        = string
  description = "ID of the remote virtual network"
}