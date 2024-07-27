locals {
  common = {
    memory = 16384
    vcpu = 4
    disk_size = 250
    bridgename = "br30"
    iso_path = "/home/abasit/downloads/cloud-images/ubuntu-22-cloud-image/ubuntu22-disk.qcow2"
    iso_url  = "file:///home/abasit/downloads/iso/jammy-server-cloudimg-amd64.img"
    ipv4mask = "24"
    ipv4gw   = "192.168.30.1"
    ipv4ns   = "192.168.30.1"
    ipv6mask = "64"
    ipv6gw   = "2001:470:ee86:30::1"
    ipv6ns   = "2001:470:ee86:30::1"
  }
  host1 = {
    pool1 = "default"
    pool2 = "zp_sda_sdb-images"
    pool3 = "zp_nvmpci1-images" # pool on nvme disk
  }
  host2 = {
    pool1 = "default"
    pool2 = "zp_hdd01-images"
    pool3 = "zp_ssd01-images"
    
  }
}


module "k8sneo_m1" {
  source = "../modules/libvirt_vm"
  
  # Set input variables here
  vm_hostname_prefix = "k8sneo_m1"
  autostart          = true
  memory             = local.common.memory
  vcpu               = local.common.vcpu
  dhcp               = false
  ip_address         = ["192.168.30.26"]
  ip6_address        = ["2001:470:ee86:30:192:168:30:26"]
  ip_gateway         = local.common.ipv4gw
  ip6_gateway        = local.common.ipv6gw
  ip_nameserver      = local.common.ipv4ns
  ip6_nameserver     = local.common.ipv6ns
  bridge             = local.common.bridgename
  pool               = local.host1.pool2
  system_volume      = local.common.disk_size
  ssh_admin          = "k8s"
  ssh_admin_passwd   = "$6$rounds=4096$hSjO/nCBqa/ottYL$mg7Z4dlx6FR0Tpy1NOn.cWJ9926sfr0bV9V/gVwNUIyKHU9nHsYhqpbtaQjLEjuANW0BMRUiTiJe7PjAV4eER1"
  root_passwd        = "$6$rounds=4096$hSjO/nCBqa/ottYL$mg7Z4dlx6FR0Tpy1NOn.cWJ9926sfr0bV9V/gVwNUIyKHU9nHsYhqpbtaQjLEjuANW0BMRUiTiJe7PjAV4eER1"
  ssh_private_key    = "~/.ssh/terraform_vm"
  ssh_keys    = [
    chomp(file("~/.ssh/terraform_vm.pub"))
    ]
  os_img_url         = local.common.iso_url

  # Required provider configuration
  providers = {
    libvirt = libvirt.host1
  }
}

module "k8sneo_w1" {
  source = "../modules/libvirt_vm"
  
  # Set input variables here
  vm_hostname_prefix = "k8sneo_w1"
  autostart          = true
  memory             = local.common.memory
  vcpu               = local.common.vcpu
  dhcp               = false
  ip_address         = ["192.168.30.29"]
  ip6_address        = ["2001:470:ee86:30:192:168:30:29"]
  ip_gateway         = local.common.ipv4gw
  ip6_gateway        = local.common.ipv6gw
  ip_nameserver      = local.common.ipv4ns
  ip6_nameserver     = local.common.ipv6ns
  bridge             = local.common.bridgename
  pool               = local.host1.pool2
  system_volume      = local.common.disk_size
  ssh_admin          = "k8s"
  ssh_admin_passwd   = "$6$rounds=4096$hSjO/nCBqa/ottYL$mg7Z4dlx6FR0Tpy1NOn.cWJ9926sfr0bV9V/gVwNUIyKHU9nHsYhqpbtaQjLEjuANW0BMRUiTiJe7PjAV4eER1"
  root_passwd        = "$6$rounds=4096$hSjO/nCBqa/ottYL$mg7Z4dlx6FR0Tpy1NOn.cWJ9926sfr0bV9V/gVwNUIyKHU9nHsYhqpbtaQjLEjuANW0BMRUiTiJe7PjAV4eER1"
  ssh_private_key    = "~/.ssh/terraform_vm"
  ssh_keys    = [
    chomp(file("~/.ssh/terraform_vm.pub"))
    ]
  os_img_url         = local.common.iso_url

  # Required provider configuration
  providers = {
    libvirt = libvirt.host2
  }
}

#module "k8sneo_m2" {
#  source = "../modules/libvirt_vm"
#  
#  # Set input variables here
#  vm_hostname_prefix = "k8sneo_m2"
#  autostart          = true
#  memory             = local.common.memory
#  vcpu               = local.common.vcpu
#  dhcp               = false
#  ip_address         = ["192.168.30.27"]
#  ip6_address        = ["2001:470:ee86:30:192:168:30:27"]
#  ip_gateway         = local.common.ipv4gw
#  ip6_gateway        = local.common.ipv6gw
#  ip_nameserver      = local.common.ipv4ns
#  ip6_nameserver     = local.common.ipv6ns
#  bridge             = local.common.bridgename
#  pool               = local.host2.pool1
#  system_volume      = local.common.disk_size
#  ssh_admin          = "k8s"
#  ssh_admin_passwd   = "$6$rounds=4096$hSjO/nCBqa/ottYL$mg7Z4dlx6FR0Tpy1NOn.cWJ9926sfr0bV9V/gVwNUIyKHU9nHsYhqpbtaQjLEjuANW0BMRUiTiJe7PjAV4eER1"
#  root_passwd        = "$6$rounds=4096$hSjO/nCBqa/ottYL$mg7Z4dlx6FR0Tpy1NOn.cWJ9926sfr0bV9V/gVwNUIyKHU9nHsYhqpbtaQjLEjuANW0BMRUiTiJe7PjAV4eER1"
#  ssh_private_key    = "~/.ssh/terraform_vm"
#  ssh_keys    = [
#    chomp(file("~/.ssh/terraform_vm.pub"))
#    ]
#  os_img_url         = local.common.iso_url
#
#  # Required provider configuration
#  providers = {
#    libvirt = libvirt.host2
#  }
#}
#
#module "k8sneo_m3" {
#  source = "../modules/libvirt_vm"
#  
#  # Set input variables here
#  vm_hostname_prefix = "k8sneo_m3"
#  autostart          = true
#  memory             = local.common.memory
#  vcpu               = local.common.vcpu
#  dhcp               = false
#  ip_address         = ["192.168.30.28"]
#  ip6_address        = ["2001:470:ee86:30:192:168:30:28"]
#  ip_gateway         = local.common.ipv4gw
#  ip6_gateway        = local.common.ipv6gw
#  ip_nameserver      = local.common.ipv4ns
#  ip6_nameserver     = local.common.ipv6ns
#  bridge             = local.common.bridgename
#  pool               = local.host2.pool2
#  system_volume      = local.common.disk_size
#  ssh_admin          = "k8s"
#  ssh_admin_passwd   = "$6$rounds=4096$hSjO/nCBqa/ottYL$mg7Z4dlx6FR0Tpy1NOn.cWJ9926sfr0bV9V/gVwNUIyKHU9nHsYhqpbtaQjLEjuANW0BMRUiTiJe7PjAV4eER1"
#  root_passwd        = "$6$rounds=4096$hSjO/nCBqa/ottYL$mg7Z4dlx6FR0Tpy1NOn.cWJ9926sfr0bV9V/gVwNUIyKHU9nHsYhqpbtaQjLEjuANW0BMRUiTiJe7PjAV4eER1"
#  ssh_private_key    = "~/.ssh/terraform_vm"
#  ssh_keys    = [
#    chomp(file("~/.ssh/terraform_vm.pub"))
#    ]
#  os_img_url         = local.common.iso_url
#
#  # Required provider configuration
#  providers = {
#    libvirt = libvirt.host2
#  }
#}