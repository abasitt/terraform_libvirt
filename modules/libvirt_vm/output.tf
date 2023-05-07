#output "vm_ips" {
#  value = libvirt_domain.domain-ubuntu[*].network_interface[*].addresses[0]
#}

output "vm_names" {
  value = libvirt_domain.domain-ubuntu[*].name
}


