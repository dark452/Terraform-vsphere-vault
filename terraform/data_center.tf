data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore" "datastore" {
  for_each      = var.datastore_mapping
  name          = each.value.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  count         = var.vsphere_cluster_enabled == false ? 0 : 1
  name          = var.vsphere_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  count         = var.vsphere_cluster_enabled != false ? 0 : length(var.vsphere_hosts)
  name          = "${var.vsphere_hosts[count.index]}/Resources"
  datacenter_id = data.vsphere_datacenter.dc.id
}


data "vsphere_host" "esxi_hosts" {
  count         = length(var.vsphere_hosts)
  name          = var.vsphere_hosts[count.index]
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "vm_network" {
  name          = var.vm_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_content_library" "library" {
  name = var.vsphere_content_library
}

data "vsphere_content_library_item" "template" {
  name       = var.vm_template_name
  type       = "vm-template"
  library_id = data.vsphere_content_library.library.id
}