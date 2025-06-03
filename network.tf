resource "azurerm_virtual_network" "vnet-test" {
  name                = "vnet-zuzzurello-test-weu"
  location            = azurerm_resource_group.rg-test.location
  resource_group_name = azurerm_resource_group.rg-test.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet-test-frontend" {
  name                 = "subnet-zuzzurello-test-weu-frontend"
  resource_group_name  = azurerm_resource_group.rg-test.name
  virtual_network_name = azurerm_virtual_network.vnet-test.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet-test-backend" {
  name                 = "subnet-zuzzurello-test-weu-backend"
  resource_group_name  = azurerm_resource_group.rg-test.name
  virtual_network_name = azurerm_virtual_network.vnet-test.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "subnet-test-postgresql" {
  name                 = "subnet-zuzzurello-test-weu-postgresql"
  resource_group_name  = azurerm_resource_group.rg-test.name
  virtual_network_name = azurerm_virtual_network.vnet-test.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_public_ip" "pip-test" {
  name                = "pip-zuzzurello-test-weu"
  location            = azurerm_resource_group.rg-test.location
  resource_group_name = azurerm_resource_group.rg-test.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic-test-frontend" {
  name                = "nic-zuzzurello-test-weu-frontend"
  location            = azurerm_resource_group.rg-test.location
  resource_group_name = azurerm_resource_group.rg-test.name

  ip_configuration {
    name                          = "ipconfig-zuzzurello-test-weu-frontend"
    subnet_id                     = azurerm_subnet.subnet-test-frontend.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip-test.id
  }
}

resource "azurerm_network_interface" "nic-test-backend" {
  name                = "nic-zuzzurello-test-weu-backend"
  location            = azurerm_resource_group.rg-test.location
  resource_group_name = azurerm_resource_group.rg-test.name

  ip_configuration {
    name                          = "ipconfig-zuzzurello-test-weu-backend"
    subnet_id                     = azurerm_subnet.subnet-test-backend.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip-test.id
  }
}

resource "azurerm_network_interface" "nic-test-postgresql" {
  name                = "nic-zuzzurello-test-weu-postgresql"
  location            = azurerm_resource_group.rg-test.location
  resource_group_name = azurerm_resource_group.rg-test.name

  ip_configuration {
    name                          = "ipconfig-zuzzurello-test-weu-postgresql"
    subnet_id                     = azurerm_subnet.subnet-test-postgresql.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip-test.id
  }
}