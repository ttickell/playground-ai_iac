variable "subscription_id" {
  type        = string
  description = "The Azure Subscription ID"
  default = "d5b7ad7b-499c-4072-83dd-86217ad832dd"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
  default = "playground-resources"
}

variable "virtual_network_name" {
  type        = string
  description = "The name of the virtual network"
  default = "playground-vnet"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "The address space of the virtual network"
  default = ["10.0.0.0/16"]
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet"
  default = "default"
}

variable "subnet_address_prefixes" {
  type        = list(string)
  description = "The address prefixes of the subnet"
  default = ["10.0.1.0/24"]
}

variable "network_security_group_name" {
  type        = string
  description = "The name of the network security group"
  default = "playground-nsg"
}

variable "public_ip_name" {
  type        = string
  description = "The name of the public IP"
  default = "playground-public-ip"
}

variable "public_ip_allocation_method" {
  type        = string
  description = "The allocation method of the public IP"
  default = "Dynamic"
}

variable "public_ip_sku" {
  type        = string
  description = "The SKU of the public IP"
  default = "Basic"
}

variable "network_interface_name" {
  type        = string
  description = "The name of the network interface"
  default = "playground-nic"
}

variable "private_ip_address_allocation" {
  type        = string
  description = "The private IP address allocation method"
  default = "Dynamic"
}

variable "vm_name" {
  type        = string
  description = "The name of the virtual machine"
  default = "playground-vm"
}

variable "vm_size" {
  type        = string
  description = "The size of the virtual machine"
  default = "Standard_B2s"
}

variable "os_disk_storage_account_type" {
  type        = string
  description = "The storage account type of the OS disk"
  default = "Standard_LRS"
}

variable "os_disk_size_gb" {
  type        = number
  description = "The size of the OS disk in GB"
  default = 64
}

variable "os_image_publisher" {
  type        = string
  description = "The publisher of the OS image"
  default = "RedHat"
}

variable "os_image_offer" {
  type        = string
  description = "The offer of the OS image"
  default = "RHEL"
}

variable "os_image_sku" {
  type        = string
  description = "The SKU of the OS image"
  default = "8-gen2"
}

variable "os_image_version" {
  type        = string
  description = "The version of the OS image"
  default = "latest"
}

variable "vm_computer_name" {
  type        = string
  description = "The computer name of the virtual machine"
  default = "playground-vm"
}

variable "admin_username" {
  type        = string
  description = "The admin username of the virtual machine"
  default = "azureuser"
}

variable "disable_password_authentication" {
  type        = bool
  description = "Whether to disable password authentication"
  default = true
}

variable "admin_ssh_public_key_path" {
  type        = string
  description = "The path to the admin SSH public key"
  default = "~/.ssh/id_rsa.pub"
}
