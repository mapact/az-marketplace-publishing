##############################################################################
# Variables File
# 
# Here is where we store the default values for all the variables used in our
# Terraform code. If you create a variable with no default, the user will be
# prompted to enter it (or define it via config file or command line flags.)
 
variable "subscription_id" {
  description = "The ID of your Azure Subscripion."
  default     = "null"
}

variable "location" {
  description = "The default Azure region."
  default     = "southeastasia"
}

variable "resource_group_name" {
  description = "The name of your Azure Resource Group."
  default     = "demo-rg"
}

variable "virtual_network_name" {
  description = "The name for your virtual network."
  default     = "demo-vnet"
}

variable "virtual_network_address_space" {
  description = "The address space that is used by the virtual network. You can supply more than one address space. Changing this forces a new resource to be created."
  default     = ["192.168.0.0/24"]
}

variable "app_subnet_prefix" {
  description = "The address prefix to use for the subnet."
  default     = "192.168.0.64/28"
}

variable "app_subnet_nsg_name" {
  description = "The name of the NSG for the Application subnet."
  default     = "app-subnet-nsg"
}