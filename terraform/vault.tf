data "vault_kv_secret_v2" "vcenter" {
  mount = var.vault_vcenter_secret_path
  name  = "vcenter"
}

data "vault_kv_secret_v2" "ssh_keys" {
  mount = var.vault_vcenter_secret_path
  name  = "ssh_keys/your_user"
}