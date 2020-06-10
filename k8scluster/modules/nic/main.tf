resource "azurerm_network_interface" "nic" {
    count               = "${length(var.nics)}"
    name                = "${var.nics[count.index]}"
    location                  = "${var.location}"
    resource_group_name       = "${var.rgname}"
    network_security_group_id = "${var.nsgids[count.index]}"
    ip_configuration {
        name                          = "${var.ip_configs[count.index]}"
        subnet_id                     = "${var.subnetid}"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = "${var.publicips[count.index]}"
    }

    tags = {
        environment = "${var.environment}"
    }
}