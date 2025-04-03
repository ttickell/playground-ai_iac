# Configure the Azure Provider
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id # Replace with your Azure subscription ID
}

# Define the Resource Group (using existing one)
data "azurerm_resource_group" "playground" {
  name = var.resource_group_name
}

# Create the Virtual Network
module "virtual_network" {
  source              = "./modules/virtual_network"
  resource_group_name = data.azurerm_resource_group.playground.name
  location            = data.azurerm_resource_group.playground.location
  virtual_network_name = var.virtual_network_name
  address_space       = var.vnet_address_space
}

# Create the Subnet
module "subnet" {
  source              = "./modules/subnet"
  resource_group_name = data.azurerm_resource_group.playground.name
  virtual_network_name = module.virtual_network.virtual_network_name
  subnet_name         = var.subnet_name
  address_prefixes    = var.subnet_address_prefixes
  depends_on = [module.virtual_network]
}

# Create the Network Security Group
module "network_security_group" {
  source              = "./modules/network_security_group"
  resource_group_name = data.azurerm_resource_group.playground.name
  location            = data.azurerm_resource_group.playground.location
  network_security_group_name = var.network_security_group_name
}

# Create the Public IP
module "public_ip" {
  source              = "./modules/public_ip"
  resource_group_name = data.azurerm_resource_group.playground.name
  location            = data.azurerm_resource_group.playground.location
  public_ip_name      = var.public_ip_name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
}

# Create the Network Interface
module "network_interface" {
  source              = "./modules/network_interface"
  resource_group_name = data.azurerm_resource_group.playground.name
  location            = data.azurerm_resource_group.playground.location
  network_interface_name = var.network_interface_name
  subnet_id           = module.subnet.subnet_id
  private_ip_address_allocation = var.private_ip_address_allocation
  public_ip_address_id = module.public_ip.public_ip_id
  network_security_group_id = module.network_security_group.network_security_group_id
  depends_on = [module.subnet, module.public_ip, module.network_security_group]
}

# Create the Virtual Machine
module "virtual_machine" {
  source              = "./modules/virtual_machine"
  resource_group_name = data.azurerm_resource_group.playground.name
  location            = data.azurerm_resource_group.playground.location
  vm_name             = var.vm_name
  vm_size             = var.vm_size
  network_interface_ids = [module.network_interface.network_interface_id]
  os_disk_storage_account_type = var.os_disk_storage_account_type
  os_disk_size_gb     = var.os_disk_size_gb
  os_image_publisher  = var.os_image_publisher
  os_image_offer      = var.os_image_offer
  os_image_sku        = var.os_image_sku
  os_image_version    = var.os_image_version
  vm_computer_name    = var.vm_computer_name
  admin_username      = var.admin_username
  disable_password_authentication = var.disable_password_authentication
  admin_ssh_public_key_path = var.admin_ssh_public_key_path
  depends_on = [module.network_interface]
}

# Outputs
output "public_ip_address" {
  value       = module.public_ip.public_ip_address
  description = "The public IP address of the VM"
}

output "vm_id" {
  value       = module.virtual_machine.vm_id
  description = "The ID of the VM"
}

output "private_ip_address" {
  value       = module.virtual_machine.private_ip_address
  description = "The private IP address of the VM"
}
