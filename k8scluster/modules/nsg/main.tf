resource "azurerm_network_security_group" "nsg" {
    count               = "${length(var.nsgs)}"
    name                = "${var.nsgs[count.index]}"
    location            = "${var.location}"
    resource_group_name = "${var.rgname}"
    
    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "${var.environment}"
    }
}