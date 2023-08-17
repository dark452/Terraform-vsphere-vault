# Configure the vSphere provider

provider "vsphere" {
  user                 = var.vsphereuser
  password             = data.vault_generic_secret.vcenter_password.data["secure_user_password"]
  vsphere_server       = var.vsphere_vcenter
  allow_unverified_ssl = var.vsphere_unverified_ssl # In case your vCenter is using internal CA certificate
}

provider "vault" {

  address         = var.vault_server_url
  skip_tls_verify = var.vault_skip_tls # In case your Vault server is using internal CA certificate
  token           = var.vault_token    #basic config
}