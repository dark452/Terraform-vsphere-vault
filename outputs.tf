output "VMs_ip_addresses" {
  value = vsphere_virtual_machine.vm_template.*.default_ip_address
}

output "vmware_tools_status" {
  value = vsphere_virtual_machine.vm_template.vmware_tools_status
}