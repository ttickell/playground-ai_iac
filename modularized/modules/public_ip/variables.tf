variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The location of the resource group"
}

variable "public_ip_name" {
  type        = string
  description = "The name of the public IP"
}

variable "allocation_method" {
  type        = string
  description = "The allocation method of the public IP"
}

variable "sku" {
  type        = string
  description = "The SKU of the public IP"
}
