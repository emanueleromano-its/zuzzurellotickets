resource "azurerm_ssh_public_key" "ssh_key" {
  name                = "ssh-key-zuzzurello-test-weu"
  resource_group_name = azurerm_resource_group.rg-test.name
  location            = azurerm_resource_group.rg-test.location
  public_key         = file(var.ssh_public_key_path)
}