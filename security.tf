# Regole di sicurezza frontend
resource "azurerm_network_security_rule" "http_https_ingress" {
  name                        = "Allow-HTTP-HTTPS-Ingress"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges      = ["80", "443"]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg-test.name
  network_security_group_name = azurerm_network_security_group.nsg-test-frontend.name
}

resource "azurerm_network_security_rule" "backend_traffic_egress" {
  name                        = "Allow-Backend-Traffic-Egress"
  priority                    = 200
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges      = ["80", "443"] # Modifica con le porte applicative necessarie
  source_address_prefix       = "*"
  destination_address_prefix  = azurerm_subnet.subnet-test-backend.address_prefixes[0]
  resource_group_name         = azurerm_resource_group.rg-test.name
  network_security_group_name = azurerm_network_security_group.nsg-test-frontend.name
}

resource "azurerm_network_security_rule" "block_all_ingress" {
  name                        = "Deny-All-Ingress"
  priority                    = 300
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg-test.name
  network_security_group_name = azurerm_network_security_group.nsg-test-frontend.name
}

# Regole di sicurezza backend

resource "azurerm_network_security_rule" "backend_ingress" {
  name                        = "Allow-Backend-Ingress"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges      = ["80", "443"] # Modifica con le porte applicative necessarie
  source_address_prefix       = azurerm_subnet.subnet-test-frontend.address_prefixes[0]
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg-test.name
  network_security_group_name = azurerm_network_security_group.nsg-test-backend.name
}

resource "azurerm_network_security_rule" "db_traffic_egress" {
  name                        = "Allow-DB-Traffic-Egress"
  priority                    = 200
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges      = ["1433", "3306"] # Modifica con le porte del database necessarie
  source_address_prefix       = "*"
  destination_address_prefix  = azurerm_subnet.subnet-test-postgresql.address_prefixes[0]
  resource_group_name         = azurerm_resource_group.rg-test.name
  network_security_group_name = azurerm_network_security_group.nsg-test-backend.name
}

# Regole di sicurezza PostgreSQL
resource "azurerm_network_security_rule" "db_ingress" {
  name                        = "Allow-DB-Ingress"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges      = ["1433", "3306"] # Modifica con le porte del database necessarie
  source_address_prefix       = azurerm_subnet.subnet-test-backend.address_prefixes[0]
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg-test.name
  network_security_group_name = azurerm_network_security_group.nsg-test-postgresql.name
}

# Regole di sicurezza Jumpbox
resource "azurerm_network_security_rule" "jumpbox_ingress" {
  name                        = "Allow-Jumpbox-Ingress"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges      = ["22", "3389"] # Modifica con le porte SSH/RDP necessarie
  source_address_prefix       = var.admin_ip # Sostituisci con l'IP amministrativo
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg-test.name
  network_security_group_name = azurerm_network_security_group.nsg-test-jumpbox.name
}

resource "azurerm_network_security_rule" "jumpbox_egress" {
  name                        = "Allow-Jumpbox-Egress"
  priority                    = 200
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg-test.name
  network_security_group_name = azurerm_network_security_group.nsg-test-jumpbox.name
}

resource "azurerm_network_security_rule" "jumpbox_block_all_ingress" {
  name                        = "Deny-All-Jumpbox-Ingress"
  priority                    = 300
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg-test.name
  network_security_group_name = azurerm_network_security_group.nsg-test-jumpbox.name
}

resource "azurerm_network_security_rule" "jumpbox_block_all_egress" {
  name                        = "Deny-All-Jumpbox-Egress"
  priority                    = 300
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg-test.name
  network_security_group_name = azurerm_network_security_group.nsg-test-jumpbox.name
}