locals {
    resource_group_name = "firewall-spoke-rg"
    location = "eastus"
    virtual_network_name = "spoke-vnet"
    virtual_network_address_space = ["10.1.0.0/16"]
    subnet_name = "spoke-subnet"
    subnet_address_prefixes = ["10.1.0.0/24"]
    peering_name = "spoke-hub-peering"
    nsg_name = "spoke-subnet-nsg"
}

module "spoke-rg" {
    source = "../modules/resource_group"
    resource_group_name = local.resource_group_name
    location = local.location
}

module "spoke-vnet" {
    source = "../modules/virtual_network"
    virtual_network_name = local.virtual_network_name
    location = local.location
    resource_group_name = local.resource_group_name
    address_space = local.virtual_network_address_space
    depends_on = [ module.spoke-rg ]
}

module "spoke-subnet" {
    source = "../modules/virtual_network_subnet"
    subnet_name = local.subnet_name
    resource_group_name = local.resource_group_name
    virtual_network_name = local.virtual_network_name
    subnet_address_prefixes = local.subnet_address_prefixes
    depends_on = [ module.spoke-vnet ]
}

module "spoke-hub-peering" {
    source = "../modules/virtual_network_peering"
    peering_name = local.peering_name
    virtual_network_name = local.virtual_network_name
    resource_group_name = local.resource_group_name
    remote_virtual_network_id = data.azurerm_virtual_network.hub-vnet.id
    depends_on = [ module.spoke-vnet ]
}

module "spoke-subnet-nsg" {
    source = "../modules/network_security_group"
    nsg_name = local.nsg_name
    location = local.location
    resource_group_name = local.resource_group_name
    security_rules = [{
        name = "allow-ssh"
        priority = 1001
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "22"
        source_address_prefix = "*"
        destination_address_prefix = "*"
    }, {
        name = "allow-rdp",
        priority = 1002,
        direction = "Inbound",
        access = "Allow",
        protocol = "Tcp",
        source_port_range = "*",
        destination_port_range = "3389",
        source_address_prefix = "*",
        destination_address_prefix = "*"
    }]
    depends_on = [ module.spoke-rg ]
}

module "spoke-subnet-nsg-association" {
    source = "../modules/subnet_network_security_group_association"
    subnet_id = module.spoke-subnet.subnet_id
    network_security_group_id = module.spoke-subnet-nsg.network_security_group_id
    depends_on = [ module.spoke-subnet, module.spoke-subnet-nsg ]
}

module "ubuntu-vm" {
    source = "../modules/virtual_machine_linux"
    virtual_machine_name = "ubuntu"
    resource_group_name = local.resource_group_name
    location = local.location
    admin_password = "P@ssw0rd1234!"
    admin_username = "azureuser"
    subnet_id = module.spoke-subnet.subnet_id
    deploy_public_ip = true
    depends_on = [ module.spoke-subnet ]
}