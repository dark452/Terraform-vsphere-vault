# Terraform-vsphere-vault

Example project to provision virtual machines in VMware vsphere using hashicorp vault to manage the secrets

## Details

This project aims to address the following use case:

- vSphere implementation with several datacenters and these dc's may or may not have cluster configured.
- More than one datastore
- The http configuration in the `provider.tf` file, is for using http backend (for instance Gitlab)

We use cloud-init to setup the network/os related configuration:

- Nameservers
- IP/Mask
- Gateway
- Search
- Hostname
- FQDN
- User creation
- SSH keys
