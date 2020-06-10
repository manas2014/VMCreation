resource "azurerm_virtual_network" "vnet" {
    name                = "${var.vnetname}"
    address_space       =  "${var.address_space}"
    location            = "${var.location}"
    resource_group_name = "${var.rgname}"

    tags = {
        environment = "${var.environment}"
    }
}

