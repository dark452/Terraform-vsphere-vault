data "vault_generic_secret" "vcenter_password" {
  path = var.vault_secret_path
}