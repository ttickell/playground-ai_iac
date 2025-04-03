# Create a subnet (you might need to create one if it doesn't exist)
# This example assumes you have a subnet named "default" in the VNet
# If you don't have one, uncomment the resource block below to create one.
data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
  depends_on = [azurerm_subnet.subnet]
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes
}
