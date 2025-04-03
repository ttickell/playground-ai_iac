variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The location of the resource group"
}

variable "vm_name" {
  type        = string
  description = "The name of the virtual machine"
}

variable "vm_size" {
  type        = string
  description = "The size of the virtual machine"
}

variable "network_interface_ids" {
  type        = list(string)
  description = "The IDs of the network interfaces"
}

variable "os_disk_storage_account_type" {
  type        = string
  description = "The storage account type of the OS disk"
}

variable "os_disk_size_gb" {
  type        = number
  description = "The size of the OS disk in GB"
}

variable "os_image_publisher" {
  type        = string
  description = "The publisher of the OS image"
}

variable "os_image_offer" {
  type        = string
  description = "The offer of the OS image"
}

variable "os_image_sku" {
  type        = string
  description = "The SKU of the OS image"
}

variable "os_image_version" {
  type        = string
  description = "The version of the OS image"
}

variable "vm_computer_name" {
  type        = string
  description = "The computer name of the virtual machine"
}

variable "admin_username" {
  type        = string
  description = "The admin username of the virtual machine"
}

variable "disable_password_authentication" {
  type        = bool
  description = "Whether to disable password authentication"
}

variable "admin_ssh_public_key_path" {
  type        = string
  description = "The path to the admin SSH public key"
}
