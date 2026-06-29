terraform {
  backend "http" {
  }
}
# Configure the vSphere provider
provider "vsphere" {
  user                 = data.vault_kv_secret_v2.vcenter.data["vsphere_user"]
  password             = data.vault_kv_secret_v2.vcenter.data["vsphere_pass"]
  vsphere_server       = var.vsphere_vcenter
  allow_unverified_ssl = var.vsphere_unverified_ssl
}

provider "vault" {
  address         = var.vault_server_url
  skip_tls_verify = var.vault_skip_tls
}