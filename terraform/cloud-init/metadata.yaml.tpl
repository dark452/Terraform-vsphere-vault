instance-id: ${hostname}
network:
  version: 2
  ethernets:
    ens192:
      dhcp4: false #true to use dhcp
      addresses:
        - ${ipv4-address}/${ipv4-netmask} #Set you ip here
      gateway4: ${ipv4-gateway} # Set gw here 
      nameservers:
        addresses:
          ${dns}
        search: 
          ${search}