# Configure the Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "d5b7ad7b-499c-4072-83dd-86217ad832dd" # Replace with your Azure subscription ID
}

# Define the Resource Group (using existing one)
data "azurerm_resource_group" "playground" {
  name = "playground-resources"
}

# Define the Virtual Network
# Check if the VNet exists, if not, create it
data "azurerm_virtual_network" "playground_vnet" {
  name                = "playground-vnet"
  resource_group_name = data.azurerm_resource_group.playground.name
  # This will fail if the vnet does not exist, so we use depends_on to create it first
  depends_on = [azurerm_virtual_network.playground_vnet]
}

resource "azurerm_virtual_network" "playground_vnet" {
  name                = "playground-vnet"
  address_space       = ["10.0.0.0/16"] # Adjust as needed
  location            = data.azurerm_resource_group.playground.location
  resource_group_name = data.azurerm_resource_group.playground.name
}

# Create a subnet (you might need to create one if it doesn't exist)
# This example assumes you have a subnet named "default" in the VNet
# If you don't have one, uncomment the resource block below to create one.
data "azurerm_subnet" "playground_subnet" {
  name                 = "default"
  virtual_network_name = coalesce(data.azurerm_virtual_network.playground_vnet.name, azurerm_virtual_network.playground_vnet.name)
  resource_group_name  = data.azurerm_resource_group.playground.name
  depends_on = [azurerm_subnet.playground_subnet]
}

resource "azurerm_subnet" "playground_subnet" {
  name                 = "default"
  resource_group_name  = data.azurerm_resource_group.playground.name
  virtual_network_name = azurerm_virtual_network.playground_vnet.name
  address_prefixes     = ["10.0.1.0/24"] # Adjust as needed
}

# Define the Network Security Group
# Check if the NSG exists, if not, create it
data "azurerm_network_security_group" "playground_nsg" {
  name                = "playground-nsg"
  resource_group_name = data.azurerm_resource_group.playground.name
  depends_on = [azurerm_network_security_group.playground_nsg]
}

resource "azurerm_network_security_group" "playground_nsg" {
  name                = "playground-nsg"
  location            = data.azurerm_resource_group.playground.location
  resource_group_name = data.azurerm_resource_group.playground.name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create a Network Interface
resource "azurerm_network_interface" "playground_nic" {
  name                = "playground-nic"
  location            = data.azurerm_resource_group.playground.location
  resource_group_name = data.azurerm_resource_group.playground.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = coalesce(data.azurerm_subnet.playground_subnet.id, azurerm_subnet.playground_subnet.id)
    private_ip_address_allocation = "Dynamic" # Use "Dynamic" if you prefer dynamic allocation
    public_ip_address_id          = azurerm_public_ip.playground_public_ip.id # Added here
  }
}

# Associate the Network Security Group with the Network Interface
resource "azurerm_network_interface_security_group_association" "playground_nic_nsg_association" {
  network_interface_id      = azurerm_network_interface.playground_nic.id
  network_security_group_id = coalesce(data.azurerm_network_security_group.playground_nsg.id, azurerm_network_security_group.playground_nsg.id)
}

# Create the Virtual Machine
resource "azurerm_linux_virtual_machine" "playground_vm" {
  name                = "playground-vm"
  resource_group_name = data.azurerm_resource_group.playground.name
  location            = data.azurerm_resource_group.playground.location
  size                = "Standard_B2s" # Changed to a smaller VM size (2 vCPUs, 4 GiB RAM)
  network_interface_ids = [
    azurerm_network_interface.playground_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 64 # Reduced disk size
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "8-gen2" # Or another RHEL 8 SKU
    version   = "latest"
  }

  computer_name                   = "playground-vm"
  admin_username                  = "azureuser" # Change if needed
  #admin_password                  = "YOUR_SECURE_PASSWORD" # Change to a strong password!
  disable_password_authentication = true # Set to true if using SSH keys

  # If using SSH keys, uncomment the following block and comment out the admin_password line
  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub") # Replace with your public key path
  }
}

# Output the public IP address (if you assign one)
# If you want a public IP, you will need to create one and associate it to the NIC
resource "azurerm_public_ip" "playground_public_ip" {
  name                = "playground-public-ip"
  location            = data.azurerm_resource_group.playground.location
  resource_group_name = data.azurerm_resource_group.playground.name
  allocation_method   = "Dynamic"
  sku                 = "Basic" # Use "Standard" if you need a static IP for production workloads
}

output "public_ip_address" {
  value       = azurerm_public_ip.playground_public_ip.ip_address
  description = "The public IP address of the VM"
}

output "vm_id" {
  value       = azurerm_linux_virtual_machine.playground_vm.id
  description = "The ID of the VM"
}

output "private_ip_address" {
  value       = azurerm_linux_virtual_machine.playground_vm.private_ip_address
  description = "The private IP address of the VM"
}
