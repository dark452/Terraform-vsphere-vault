# Terraform-vsphere-vault

Example project to provision virtual machines in VMware vSphere using Hashicorp Vault to manage credentials.

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

You can manually test and provision VMs using the ![Static Badge](https://img.shields.io/badge/Terraform-Workflow-Gist?style=for-the-badge&link=https%3A%2F%2Fgist.github.com%2Fdark452%23terraformopentofu-workflow).

Please be aware you need to export the VAULT_ADDR environment variable to execute workflow manually.