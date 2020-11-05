##############################################################################
# This Terraform configuration will create the following:
# Resource Group
# Virtual Network and Subnets
# Network Security Groups
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
# * Resource Group
resource "azurerm_resource_group" "group" {
  name     = var.resource_group_name
  location = var.location
}

##############################################################################
# * Virtual Network and Subnets
resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  location            = var.location
  address_space       = var.virtual_network_address_space
  resource_group_name = azurerm_resource_group.group.name
}

resource "azurerm_subnet" "app_subnet" {
  name                 = "ApplicationSubnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.group.name
  address_prefixes     = [var.app_subnet_prefix]
}

##############################################################################
# * Network Security Groups
resource "azurerm_network_security_group" "app_subnet_nsg" {
  name                = var.app_subnet_nsg_name
  location            = var.location
  resource_group_name = azurerm_resource_group.group.name

  security_rule {
    name                       = "AllowPowershellHttps"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5986"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "app_subnet_nsg_assoc" {
  subnet_id                 = azurerm_subnet.app_subnet.id
  network_security_group_id = azurerm_network_security_group.app_subnet_nsg.id
}