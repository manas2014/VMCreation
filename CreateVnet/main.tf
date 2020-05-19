resource "azurerm_resource_group" "dev" {
  name     = "${var.azure_resource_group_name}"
  location = "West US"
}

resource "azurerm_network_security_group" "dev" {
  name                = "acceptanceTestSecurityGroup1"
  location            = "${azurerm_resource_group.dev.location}"
  resource_group_name = "${azurerm_resource_group.dev.name}"
}

resource "azurerm_ddos_protection_plan" "dev" {
  name                = "ddospplan1"
  location            = "${azurerm_resource_group.dev.location}"
  resource_group_name = "${azurerm_resource_group.dev.name}"
}

resource "azurerm_virtual_network" "dev" {
  name                = "VNet-1"
  location            = "${azurerm_resource_group.dev.location}"
  resource_group_name = "${azurerm_resource_group.dev.name}"
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  ddos_protection_plan {
    id     = "${azurerm_ddos_protection_plan.dev.id}"
    enable = true
  }

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
  }

  subnet {
    name           = "subnet3"
    address_prefix = "10.0.3.0/24"
    security_group = "${azurerm_network_security_group.dev.id}"
  }

  tags = {
    environment = "Development"
  }
}
