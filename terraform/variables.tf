variable "vsphere_user" {
  type        = string
  default     = "Administrator@vsphere.local"
  description = "Username used to authenticate with vCenter"
}

variable "vsphere_vcenter" {
  type        = string
  default     = "your-vcenter-url"
  description = "vCenter URL. (Required) This is the vCenter Server FQDN or IP Address for vSphere API operations. Can also be specified with the VSPHERE_SERVER environment variable."
}

variable "vsphere_unverified_ssl" {
  type        = bool
  default     = true
  description = "(Optional) Boolean that can be set to true to disable SSL certificate verification. This should be used with care as it could allow an attacker to intercept your authentication token. If omitted, default value is false. Can also be specified with the VSPHERE_ALLOW_UNVERIFIED_SSL environment variable."
}

variable "vsphere_content_library" {
  type        = string
  default     = "your-content-library-name"
  description = "(Required) The name of the content library."
}

variable "vm_hosts" {
  default     = ["host1.com", "host2.com"]
  description = "List of FQDN of the Virtual machines"
}


variable "vsphere_datacenter" {
  type        = string
  default     = "my-datacenter"
  description = " (Optional) The name of the datacenter. This can be a name or path. Can be omitted if there is only one datacenter in the inventory."
}

variable "vsphere_cluster" {
  type        = string
  default     = "RH"
  description = "(Required) The name or absolute path to the cluster."
}

variable "vsphere_cluster_enabled" {
  type    = bool
  default = false
}

variable "vsphere_pool" {
  type    = string
  default = ""
}

variable "vsphere_hosts" {
  type    = list(any)
  default = ["host1", "host2"]
}

variable "vm_datastore" {
  type    = list(any)
  default = ["datastore1", "datastore2"]
}

variable "datastore_mapping" {
  default = {
    mapping1 = {
      host     = "X.x.x.x"
      datatore = "Datastore 1"
    },
    mapping2 = {
      host      = "x.x.x.x"
      datastore = "Datastore 2"
    }
  }
}

variable "vm_network" {
  type = string
}

variable "vm_cpu" {
  type    = string
  default = "1"
}
#Memory in Kb
variable "vm_mem" {
  type    = string
  default = "4096"
}

variable "vm_disks" {
  description = "VM disks definitions (sizes)"
  type        = list(any)
  default     = ["100", "200"]

}

variable "vm_prefix" {
  type    = string
  default = "vm"
}

variable "vm_suffix" {
  type    = string
  default = "dev"
}

variable "vm_template_name" {
  type = string
}

variable "vm_domain" {
  type = string
}

variable "ipv4_netmask" {
  type    = string
  default = "24"
}

variable "vm_firmware" {
  type        = string
  default     = "bios"
  description = "(Optional) The firmware for the virtual machine. One of bios or efi"
}

variable "dns" {
  default = ["8.8.8.8"]
}

variable "search" {
  default = "your-host.com"
}


#Vault variables

variable "vault_server_url" {
  type        = string
  default     = "https://myvault.com:8200/"
  description = "(Required) Origin URL of the Vault server. This is a URL with a scheme, a hostname and a port but with no path. May be set via the VAULT_ADDR environment variable."
}

variable "vault_skip_tls" {
  type        = bool
  default     = true
  description = "(Optional) Set this to true to disable verification of the Vault server's TLS certificate."
}

variable "vault_vcenter_secret_path" {
  type        = string
  default     = "mykv"
  description = "The path where the actual secret was stored in the vault server"
}