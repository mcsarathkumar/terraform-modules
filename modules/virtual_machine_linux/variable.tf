variable "location" {
    type = string
    description = "Location of the Virtual Network"
}

variable "resource_group_name" {
    type = string
    description = "Name of the resource group"
}

variable "virtual_machine_name" {
    type = string
    description = "Name of the virtual network"
}

variable "vm_size" {
    type = string
    description = "(optional) describe your variable"
    default = "Standard_B1s"
}

variable "admin_username" {
    type = string
    description = "Admin Username"
}

variable "admin_password" {
    type = string
    description = "Admin Password"
}

variable "publisher" {
    type = string
    description = "(optional) Publisher of the image"
    default = "Canonical"
}

variable "offer" {
    type = string
    description = "(optional) Offer of the image"
    default = "0001-com-ubuntu-server-focal"
}

variable "sku" {
    type = string
    description = "(optional) SKU"
    default = "20_04-lts-gen2"
}

variable "os_version" {
    type = string
    description = "(optional) Version"
    default = "latest"
}

variable "deploy_public_ip" {
    type = bool
    description = "(optional) Deploy public IP"
    default = false
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID"
}