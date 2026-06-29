# vSphere configuration
vsphere_vcenter        = "myvcenter.redeshost.com"
vsphere_unverified_ssl = "true"

vsphere_datacenter      = "RedesHost-DC"
vsphere_cluster         = "RH-Santiago"
vsphere_cluster_enabled = true
vsphere_hosts           = ["172.16.1.10 ", "172.16.2.10"]

vm_hosts = ["iactest1", "iactest2"]

ipv4_netmask = "24"
dns          = ["172.16.1.100"]
search       = "redeshost.local"

# VM Configuration
vsphere_content_library = "Alma"
vm_template_name        = "Alma_2026"
vm_cpu                  = "4"
vm_mem                  = "4096"
vm_disks                = ["50", "100"]
datastore_mapping = {
  "mapping1" = {
    host      = "172.16.1.10"
    datastore = "MyDS1"
  }
  "mapping2" = {
    host      = "172.16.2.10"
    datastore = "MyDS2"
  }
}

vm_network  = "prod"
vm_domain   = "redeshost.com"
vm_firmware = "efi"

vault_server_url          = "https://myvault.redeshost.com:8200"
vault_skip_tls            = false
vault_vcenter_secret_path = "kv"
