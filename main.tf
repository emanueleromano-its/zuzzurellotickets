resource "azurerm_resource_group" "rg-test" {
  name     = "rg-zuzzurello-test-weu"
  location = "West Europe"
}

resource "azurerm_public_ip" "pip-test" {
  name                = "pip-zuzzurello-test-weu"
  location            = azurerm_resource_group.rg-test.location
  resource_group_name = azurerm_resource_group.rg-test.name
  allocation_method   = "Static"
}