resource "azurerm_public_ip" "public_ip" {

    count                        = length(var.public_ips)
    name                         = var.public_ips[count.index]
    location                     = var.location
    resource_group_name          = var.rgname
    allocation_method            = var.allocation_method
   
    tags = {
        environment = var.environment
    }
}
