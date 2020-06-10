resource "azurerm_subnet" "subnet" {
    name                 = "${var.subnetname}"
    resource_group_name  = "${var.rgname}"
    virtual_network_name = "${var.vnetname}"
    address_prefix       = "${var.address_prefix}"
}