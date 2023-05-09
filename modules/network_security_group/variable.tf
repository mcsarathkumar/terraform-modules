variable "nsg_name" {
  type        = string
  description = "Name of the Network Security Group"
}

variable "location" {
  type        = string
  description = "Location of Network Security Group"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "security_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  description = "Security rules of the Network Security Group"
}