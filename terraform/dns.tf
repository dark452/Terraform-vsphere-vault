data "dns_a_record_set" "vm_host_info" {
  count = length(var.vm_hosts)
  host  = var.vm_hosts[count.index]
}