
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
  ip6_address        = ["2001:470:ee86:30:192:168:30:59"]
  ip_gateway         = "192.168.30.1"
  ip6_gateway        = "2001:470:ee86:30::1"
  bridge             = "br30"
  pool               = "zp_sda_sdb-images"
  system_volume      = 20
  ssh_admin          = "k8s"
  ssh_admin_passwd   = "$6$rounds=4096$hSjO/nCBqa/ottYL$mg7Z4dlx6FR0Tpy1NOn.cWJ9926sfr0bV9V/gVwNUIyKHU9nHsYhqpbtaQjLEjuANW0BMRUiTiJe7PjAV4eER1"
  root_passwd        = "$6$rounds=4096$hSjO/nCBqa/ottYL$mg7Z4dlx6FR0Tpy1NOn.cWJ9926sfr0bV9V/gVwNUIyKHU9nHsYhqpbtaQjLEjuANW0BMRUiTiJe7PjAV4eER1"
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
