##############################################################################
# Outputs File
#
# Expose the outputs you want your users to see after a successful 
# `terraform apply` or `terraform output` command. You can add your own text 
# and include any data from the state file. Outputs are sorted alphabetically;
# use an underscore _ to move things to the bottom. 

output "win_vm_name" {
  value = azurerm_windows_virtual_machine.win_vm.name
}

output "win_vm_pip" {
  value = azurerm_public_ip.win_vm_pip.ip_address
}

output "resource_group_name" {
  value = data.terraform_remote_state.foundation.outputs.resource_group_name
}