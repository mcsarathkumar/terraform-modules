resource "azurerm_virtual_network_peering" "virtual_network_peering" {
  name                 = var.peering_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
  remote_virtual_network_id = var.remote_virtual_network_id
}