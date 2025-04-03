# Define the Virtual Network
# Check if the VNet exists, if not, create it
data "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
  # This will fail if the vnet does not exist, so we use depends_on to create it first
  depends_on = [azurerm_virtual_network.vnet]
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}
