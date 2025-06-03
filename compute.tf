resource "azurerm_linux_virtual_machine" "vm-test-frontend" {
  name                = "vm-zuzzurello-test-weu-frontend"
  resource_group_name = azurerm_resource_group.rg-test.name
  location            = azurerm_resource_group.rg-test.location
  size               = "Standard_B1ls"
  admin_username      = "azureuser"
  network_interface_ids = [azurerm_network_interface.nic-test-frontend.id]
  os_disk {
    name = "vm-zuzzurello-osdisk-test-frontend"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
  admin_ssh_key {
    username   = "azureuser"
    public_key = azurerm_ssh_public_key.ssh_key.public_key
  }
}

resource "azurerm_linux_virtual_machine" "vm-test-backend" {
  name                = "vm-zuzzurello-test-weu-backend"
  resource_group_name = azurerm_resource_group.rg-test.name
  location            = azurerm_resource_group.rg-test.location
  size                = "Standard_B1ls"
  admin_username      = "azureuser"
  network_interface_ids = [azurerm_network_interface.nic-test-backend.id]
  os_disk {
    name = "vm-zuzzurello-osdisk-test-backend"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
  admin_ssh_key {
    username   = "azureuser"
    public_key = azurerm_ssh_public_key.ssh_key.public_key
  }
}

resource "azurerm_linux_virtual_machine" "vm-test-postgresql" {
  name                = "vm-zuzzurello-test-weu-postgresql"
  resource_group_name = azurerm_resource_group.rg-test.name
  location            = azurerm_resource_group.rg-test.location
  size                = "Standard_B1ls"
  admin_username      = "azureuser"
  network_interface_ids = [azurerm_network_interface.nic-test-postgresql.id]
  os_disk {
    name = "vm-zuzzurello-osdisk-test-postgresql"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
  admin_ssh_key {
    username   = "azureuser"
    public_key = azurerm_ssh_public_key.ssh_key.public_key
  }
}

resource "azurerm_linux_virtual_machine" "vm-test-jumpbox" {
  name                = "vm-zuzzurello-test-weu-jumpbox"
  resource_group_name = azurerm_resource_group.rg-test.name
  location            = azurerm_resource_group.rg-test.location
  size                = "Standard_B1ls"
  admin_username      = "azureuser"
  network_interface_ids = [azurerm_network_interface.nic-test-jumpbox.id]
  os_disk {
    name = "vm-zuzzurello-osdisk-test-jumpbox"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
  admin_ssh_key {
    username   = "azureuser"
    public_key = azurerm_ssh_public_key.ssh_key.public_key
  }
}