output "public_ip_address" {
  value = azurerm_public_ip.public_ip.ip_address
  description = "The public IP address"
}

output "public_ip_id" {
  value = azurerm_public_ip.public_ip.id
  description = "The ID of the public IP"
}
