variable "subnet_name" {
  type        = string
  description = "Name of the Subnet"
}

variable "virtual_network_name" {
  type        = string
  description = "Location of the Virtual Network"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "subnet_address_prefixes" {
  type        = list(string)
  description = "Address prefixes of the virtual network - subnet"
}