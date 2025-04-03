variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The location of the resource group"
}

variable "network_interface_name" {
  type        = string
  description = "The name of the network interface"
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet"
}

variable "private_ip_address_allocation" {
  type        = string
  description = "The private IP address allocation method"
}

variable "public_ip_address_id" {
  type        = string
  description = "The ID of the public IP address"
  default = null
}

variable "network_security_group_id" {
  type        = string
  description = "The ID of the network security group"
}
