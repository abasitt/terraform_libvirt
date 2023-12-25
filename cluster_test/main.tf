module "k8s_vm1" {
  source = "../modules/libvirt_vm"
  
  # Set input variables here
  vm_hostname_prefix = "test"
  autostart          = false
  vm_count           = 1
  memory             = "2048"
  vcpu               = 1
  dhcp               = true
  pool               = "zfs-vms"
  system_volume      = 20
  ssh_admin          = "admin"
  ssh_private_key    = "../.ssh/terraform_vm"
  local_admin        = "localadmin"
  local_admin_passwd = "$6$rounds=4096$xxxxxxxxHASHEDxxxPASSWORD"

  # Required provider configuration
  providers = {
    libvirt = libvirt.host1
  }
}
