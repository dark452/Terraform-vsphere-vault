# Create VM Folder
resource "vsphere_folder" "folder" {
  path          = var.vm_folder
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Create VMs
resource "vsphere_virtual_machine" "vm_template" {
  count = length(var.ipv4_address)
  name  = "${var.vm_prefix}-${count.index + 1}"
  #resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = vsphere_folder.folder.path

  num_cpus = var.vm_cpu
  memory   = var.vm_mem
  guest_id = data.vsphere_virtual_machine.template.guest_id
  firmware = "efi"

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }
  #wait_for_guest_net_timeout = 0

  disk {
    label            = "${var.vm_prefix}-${count.index + 1}-disk"
    size             = var.vm_disksize
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    linked_clone  = "false"

    customize {
      timeout = "20"

      linux_options {
        host_name = "${var.vm_prefix}-${count.index + 1}"
        domain    = var.vm_domain
      }

      network_interface {
        ipv4_address = var.ipv4_address[count.index]
        ipv4_netmask = var.ipv4_netmask
      }

      ipv4_gateway    = var.ipv4_gateway
      dns_server_list = var.dns
      dns_suffix_list = [var.vm_domain]
    }
  }
}
