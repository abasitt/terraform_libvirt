version: 2
ethernets:
  ${nic}:
    dhcp4: false
    dhcp6: false
    addresses: 
      - ${ip_address}/${ip_subnetmask}
      - ${ip6_address}/${ip6_subnetmask}
    nameservers:
       addresses:
        - ${ip_nameserver}
        - 1.1.1.1
        - 8.8.8.8
        - 2606:4700:4700::64  # Cloudflare dns64
        - 2001:4860:4860::64  # Google dns64
    routes:
      - to: default
        via: ${ip_gateway}
      - to: default  # Default IPv6
        via: ${ip6_gateway}
        on-link: true
      - to: 64:ff9b::/96  # NAT64 range
        via: ${ip6_gateway}  # NAT64 gateway
