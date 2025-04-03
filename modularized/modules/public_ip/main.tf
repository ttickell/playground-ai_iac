# Output the public IP address (if you assign one)
# If you want a public IP, you will need to create one and associate it to the NIC
resource "azurerm_public_ip" "public_ip" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method
  sku                 = var.sku
}
