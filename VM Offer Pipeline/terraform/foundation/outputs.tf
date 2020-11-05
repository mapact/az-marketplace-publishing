##############################################################################
# Outputs File
#
# Expose the outputs you want your users to see after a successful 
# `terraform apply` or `terraform output` command. You can add your own text 
# and include any data from the state file. Outputs are sorted alphabetically;
# use an underscore _ to move things to the bottom. 

output "resource_group_name" {
  value = azurerm_resource_group.group.name
}

output "diagnostics_storage_account_endpoint" {
  value = azurerm_storage_account.diagnostics.primary_blob_endpoint
}

output "app_subnet_id" {
  value = azurerm_subnet.app_subnet.id
}