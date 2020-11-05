##############################################################################
# This Terraform configuration will create the following:
# Windows Server 2019 Virtual Machine with Public IP Address
##############################################################################

# Initialize an empty AzureRm Backend
terraform {
  backend "azurerm" {
  }
}

# Configure the Azure Provider
provider "azurerm" {
  version         = "=2.34.0"
  subscription_id = var.subscription_id
  # Uncomment the line below if you are a Microsoft Partner and have a Customer Usage Attribution GUID
  # partner_id = "5fafed62-3b35-4c85-9cc7-61af1dacb6c7"
  features {}
}

##############################################################################
# * Import Existing Resources
# Remote State of deployed Foundation resources
# Azure Key Vault containing Remote PowerShell Certificate
# Base Virtual Machine Image
data "terraform_remote_state" "foundation" {
  backend = "azurerm"
  config  = {
    resource_group_name  = var.remote_state_resource_group_name
    storage_account_name = var.remote_state_storage_account_name
    container_name       = var.remote_state_container_name
    key                  = var.remote_state_key
  }
}

data "azurerm_key_vault" "keyvault" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_resource_group_name
}

data "azurerm_image" "app_image" {
  name                = var.app_image_name
  resource_group_name = var.app_image_resource_group_name
}

##############################################################################
# * Windows Server 2019 Virtual Machine with Public IP Address
resource "azurerm_public_ip" "win_vm_pip" {
  name                = "${var.win_vm_name}-pip"
  location            = var.location
  resource_group_name = data.terraform_remote_state.foundation.outputs.resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "win_vm_nic" {
  name                = "${var.win_vm_name}-nic"
  location            = var.location
  resource_group_name = data.terraform_remote_state.foundation.outputs.resource_group_name

  ip_configuration {
    name                          = "${var.win_vm_name}-ipconfig"
    subnet_id                     = data.terraform_remote_state.foundation.outputs.app_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.win_vm_pip.id
  }
}

resource "azurerm_windows_virtual_machine" "win_vm" {
  name                = "${var.win_vm_name}-vm"
  location            = var.location
  resource_group_name = data.terraform_remote_state.foundation.outputs.resource_group_name
  size                = var.win_vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  source_image_id     = data.azurerm_image.app_image.id

  network_interface_ids = [
    azurerm_network_interface.win_vm_nic.id
  ]

  os_disk {
    name                 = "${var.win_vm_name}-osdisk"
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  secret {
    key_vault_id = data.azurerm_key_vault.keyvault.id
    certificate {
      store = "My"
      url   = var.key_vault_winrm_cert_secret_url
    }
  }

  winrm_listener {
    protocol        = "Https"
    certificate_url = var.key_vault_winrm_cert_secret_url
  }
}