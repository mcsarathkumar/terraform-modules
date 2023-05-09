locals {
    resource_group_name = "firewall-hub-rg"
    location = "eastus"
    virtual_network_name = "hub-vnet"
    virtual_network_address_space = ["10.0.0.0/16"]
    subnet_name = "AzureFirewallSubnet"
    subnet_address_prefixes = ["10.0.0.0/24"]
    peering_name = "hub-spoke-peering"
}

module "hub-rg" {
    source = "../modules/resource_group"
    resource_group_name = local.resource_group_name
    location = local.location
}

module "hub-vnet" {
    source = "../modules/virtual_network"
    virtual_network_name = local.virtual_network_name
    location = local.location
    resource_group_name = local.resource_group_name
    address_space = local.virtual_network_address_space
    depends_on = [ module.hub-rg ]
}

module "hub-subnet" {
    source = "../modules/virtual_network_subnet"
    subnet_name = local.subnet_name
    resource_group_name = local.resource_group_name
    virtual_network_name = local.virtual_network_name
    subnet_address_prefixes = local.subnet_address_prefixes
    depends_on = [ module.hub-vnet ]
}

# module "hub-spoke-peering" {
#     source = "../modules/virtual_network_peering"
#     peering_name = local.peering_name
#     virtual_network_name = local.virtual_network_name
#     resource_group_name = local.resource_group_name
#     remote_virtual_network_id = data.azurerm_virtual_network.spoke-vnet.id
#     depends_on = [ module.hub-vnet ]
# }