#cloud-config
preserve_hostname: false
hostname: ${hostname}
fqdn: ${hostname}.${domain}
prefer_fqdn_over_hostname: true
users:
  - default
  - name: cloud-user
    ssh-authorized-keys:
      ${ssh_keys}
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
  - name: myuser
    ssh-authorized-keys:
      ${ssh_keys}
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
write_files:
  - content: |
      PermitRootLogin yes
    path: /etc/ssh/sshd_config.d/01-permitrootlogin.conf
  - content: |
      manual_cache_clean: True
    append: true
    path: /etc/cloud/cloud.cfg

runcmd:
  - sed -i -e 's/PasswordAuthentication\s*no/PasswordAuthentication yes/g' /etc/ssh/sshd_config.d/50-cloud-init.conf
  - systemctl restart sshd
  - systemctl restart cloud-init