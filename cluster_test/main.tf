
module "k8s_vm1" {
  source = "../modules/libvirt_vm"
  
  # Set input variables here
  vm_hostname_prefix = "test"
  autostart          = true
  vm_count           = 1
  memory             = "2048"
  vcpu               = 1
  dhcp               = false
  ip_address         = ["192.168.30.59"]
  ip_gateway         = "192.168.30.1"
  bridge             = "br30"
  pool               = "zfs-vms"
  system_volume      = 20
  ssh_admin          = "ubuntu"
  local_admin        = "localadmin"
  local_admin_passwd = "local@123"
  ssh_private_key    = "~/.ssh/terraform_vm"
  ssh_keys    = [
    chomp(file("~/.ssh/terraform_vm.pub"))
    ]
  os_img_url         = "file:///home/abasit/downloads/iso/jammy-server-cloudimg-amd64.img"

  # Required provider configuration
  providers = {
    libvirt = libvirt.host1
  }
}
