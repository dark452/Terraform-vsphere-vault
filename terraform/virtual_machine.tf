locals {
  rs_pool_id = length(data.vsphere_compute_cluster.cluster) > 0 ? data.vsphere_compute_cluster.cluster[0].resource_pool_id : null
}

# Create Server VM
resource "vsphere_virtual_machine" "vm_template" {
  count            = length(var.vm_hosts)
  name             = "${var.vm_hosts[count.index]}.${var.vm_domain}"
  resource_pool_id = var.vsphere_cluster_enabled == true ? local.rs_pool_id : data.vsphere_host.esxi_hosts[count.index].resource_pool_id
  host_system_id   = data.vsphere_host.esxi_hosts[count.index].id
  datastore_id     = data.vsphere_datastore.datastore["mapping${count.index + 1}"].id
  annotation       = "Provisioned via Terraform, DO NOT modify it manually"
  #folder           = vsphere_folder.folder.path

  num_cpus = var.vm_cpu
  memory   = var.vm_mem
  firmware = var.vm_firmware

  network_interface {
    network_id = data.vsphere_network.vm_network.id
  }
  #wait_for_guest_net_timeout = 0

  dynamic "disk" {
    for_each = var.vm_disks
    content {
      label            = "disk${disk.key}"
      size             = disk.value
      unit_number      = disk.key
      thin_provisioned = false
    }
  }

  clone {
    template_uuid = data.vsphere_content_library_item.template.id
  }

  extra_config = {
    "guestinfo.metadata" = base64encode(templatefile("./cloud-init/metadata.yaml.tpl",
      {
        hostname     = tolist(var.vm_hosts)[count.index]
        domain       = var.vm_domain
        ipv4-address = tolist(data.dns_a_record_set.vm_host_info)[count.index].addrs[0]
        ipv4-netmask = var.ipv4_netmask
        ipv4-gateway = cidrhost("${tolist(data.dns_a_record_set.vm_host_info)[count.index].addrs[0]}/${var.ipv4_netmask}", -2)
        dns          = var.dns[0]
        search       = var.search
      }
    ))
    "guestinfo.metadata.encoding" = "base64"
    "guestinfo.userdata" = base64encode(templatefile("./cloud-init/userdata.yaml.tpl",
      {
        hostname = tolist(var.vm_hosts)[count.index]
        domain   = var.vm_domain
        ssh_keys = data.vault_kv_secret_v2.ssh_keys.data["key"]
      }
    ))
    "guestinfo.userdata.encoding" = "base64"
  }
  lifecycle {
    ignore_changes = [
      custom_attributes,
      datastore_id,
      extra_config,
    ]
  }


}