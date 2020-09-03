output "public_ips" {
    value = azurerm_public_ip.public_ip.*.id
}
output "ip_addresses" {
    value = azurerm_public_ip.public_ip.*.ip_address
}