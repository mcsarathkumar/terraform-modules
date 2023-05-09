resource "azurerm_public_ip" "public_ip" {
    count = var.deploy_public_ip == true ? 1 : 0
    name                = "${var.virtual_machine_name}-pip"
    location            = var.location
    resource_group_name = var.resource_group_name
    allocation_method   = "Dynamic"
    sku                 = "Basic"
}

resource "azurerm_network_interface" "network_interface" {
  name                = "${var.virtual_machine_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.deploy_public_ip == true ? azurerm_public_ip.public_ip[0].id : null
  }
}

resource "azurerm_linux_virtual_machine" "virtual_machine" {
  name                            = var.virtual_machine_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.vm_size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.network_interface.id,
  ]

  os_disk {
    name                 = "${var.virtual_machine_name}-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.os_version
  }
}