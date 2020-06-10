resource "azurerm_storage_account" "sa" {
    count                       = "${length(var.storage_accounts)}"
    name                        = "${var.storage_accounts[count.index]}"
    resource_group_name         = "${var.rgname}"
    location                    = "${var.location}"
    account_tier                = "Standard"
    account_replication_type    = "LRS"

    tags = {
        environment = "${var.environment}"
    }
}