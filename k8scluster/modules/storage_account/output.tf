output "endpoints" {
    value = [azurerm_storage_account.sa.*.primary_blob_endpoint]
}