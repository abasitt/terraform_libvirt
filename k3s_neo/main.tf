locals {
  common = {
    memory = 16384
    vcpu = 4
    disk_size = 250
    bridgename = "br30"
    iso_path = "/home/abasit/downloads/cloud-images/ubuntu-22-cloud-image/ubuntu22-disk.qcow2"
    ipv4mask = "24"
    ipv4gw   = "192.168.30.1"
    ipv4ns   = "192.168.30.1"
    ipv6mask = "64"
    ipv6gw   = "2001:470:ee86:30::1"
    ipv6ns   = "2001:470:ee86:30::1"
  }
  host1 = {
    pool1 = "zp_sda_sdb-images"
    pool2 = "zp_sda_sdb-images-critical" # pool with zfs level sync enabled between host1 and host2
    pool3 = "zp_nvmpci1-images" # pool on nvme disk
    pool4 = "zp_nvmpci1-images-critical"
    pool5 = "default"
  }
  host2 = {
    pool1 = "zp_hdd01-images"
    pool2 = "zp_hdd01-images-critical"
    pool3 = "zp_ssd01-images"
    pool4 = "zp_ssd01-images-critical"
    pool5 = "default"
  }
}


module "k8s_vm1" {
  source = "../modules/libvirt_vm"
  
  # Set input variables here
  vm_hostname_prefix = "k3sneo_m1"
  autostart          = true
  memory             = local.common.memory
  vcpu               = local.common.vcpu
  dhcp               = false
  ip_address         = ["192.168.30.41"]
  ip6_address        = ["2001:470:ee86:30:192:168:30:41"]
  ip_gateway         = local.common.ipv4gw
  ip6_gateway        = local.common.ipv6gw
  ip_nameserver      = local.common.ipv4ns
  ip6_nameserver     = local.common.ipv6ns
  bridge             = local.common.bridgename
  pool               = local.host1.pool1
  system_volume      = local.common.disk_size
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

module "k8s_vm1" {
  source = "../modules/libvirt_vm"
  
  # Set input variables here
  vm_hostname_prefix = "k3sneo_w1"
  autostart          = true
  memory             = local.common.memory
  vcpu               = local.common.vcpu
  dhcp               = false
  ip_address         = ["192.168.30.46"]
  ip6_address        = ["2001:470:ee86:30:192:168:30:46"]
  ip_gateway         = local.common.ipv4gw
  ip6_gateway        = local.common.ipv6gw
  ip_nameserver      = local.common.ipv4ns
  ip6_nameserver     = local.common.ipv6ns
  bridge             = local.common.bridgename
  pool               = local.host2.pool1
  system_volume      = local.common.disk_size
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
    libvirt = libvirt.host2
  }
}