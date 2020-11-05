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

variable "admin_username" {
  description = "Administrator user name."
  default     = "adminuser"
}

variable "admin_password" {
  description = "Administrator password for new VMs."
  default     = "null"
}

variable "win_vm_name" {
  description = "The name and prefix for Windows VM related resources."
  default     = "demo-win-vm"
}

variable "win_vm_size" {
  description = "The size SKU of the Windows VM."
  default     = "Standard_D2as_v4"
}

variable "remote_state_resource_group_name" {
  description = "The name of the TF remote state resource group."
  default     = "remote-rg"
}

variable "remote_state_storage_account_name" {
  description = "The name of the TF remote state storage account."
  default     = "remote-storage"
}

variable "remote_state_container_name" {
  description = "The name of the TF remote state container."
  default     = "remote-container"
}

variable "remote_state_key" {
  description = "The name of the TF remote state file."
  default     = "remote-key"
}

variable "key_vault_resource_group_name" {
  description = "The resource group of the existing Key Vault."
  default     = "data-keyvault-rg"
}

variable "key_vault_name" {
  description = "The name of the existing Key Vault."
  default     = "data-keyvault"
}

variable "key_vault_winrm_cert_secret_url" {
  description = "The URL of the WinRM certificate in the Key Vault."
  default     = "https://test.vault.azure.net/secrets/certname/random"
}

variable "app_image_resource_group_name" {
  description = "The resource group of the base VM image."
  default     = "data-app-image-rg"
}

variable "app_image_name" {
  description = "The name of the base VM image."
  default     = "data-app-image"
}