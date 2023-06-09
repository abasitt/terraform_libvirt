# Resource pools and base volume

# Creates a resource pool for main (os) volumes # this is TBD if use one pool per cluster, currently i create on pool per vm
#resource "libvirt_pool" "main_resource_pool" {
#  name = "${var.cluster_name}-main-resource-pool"
#  type = "dir"
#  path = "${}/${var.cluster_name}-main-resource-pool")
#}


# Global variables
variable "k8s_common" {
  default = {
    memory = 4096
    vcpu = 2
    disk_size = 80
    bridgename = "br40"
    pool_path = "/var/lib/libvirt/images"
    volume_format = "qcow2"
    iso_path = "/home/abasit/downloads/cloud-images/ubuntu-22-cloud-image/ubuntu22-disk.qcow2"
    ipv4mask = "24"
    ipv4gw   = "192.168.40.1"
    ipv6mask = "64"
    ipv6gw   = "2001:470:ee86:4::1"
    interface = "eth0"
  }
}

# Local variables for k8s-m1 VM
locals {
  k8s_m1 = {
    hostname = "k3s-m1"
    ipv4address = "192.168.40.121"
    ipv6address = "2001:470:ee86:4:192:168:40:121"
    pool_path = "/mnt/dsk4tb1/kvm"
  }
}

# Local variables for k8s-m2 VM
locals {
  k8s_m2 = {
    hostname = "k3s-m2"
    ipv4address = "192.168.40.122"
    ipv6address = "2001:470:ee86:4:192:168:40:122"
    pool_path = "/mnt/dsk4tb1/kvm"
  }
}

locals {
  k8s_m3 = {
    hostname = "k3s-m3"
    ipv4address = "192.168.40.123"
    ipv6address = "2001:470:ee86:4:192:168:40:123"
    pool_path = "/mnt/dsk4tb1/kvm"
  }
}

module "k8s_vm_m1" {
  source = "../modules/libvirt_vm"
  
  # Set input variables here
  hostname = local.k8s_m1.hostname
  ipv4address = local.k8s_m1.ipv4address
  ipv6address = local.k8s_m1.ipv6address
  pool_path = local.k8s_m1.pool_path
  memory = var.k8s_common.memory
  vcpu = var.k8s_common.vcpu
  disk_size = var.k8s_common.disk_size
  bridgename = var.k8s_common.bridgename
  iso_path = var.k8s_common.iso_path
  volume_format = var.k8s_common.volume_format
  interface = var.k8s_common.interface

  # Required provider configuration
  providers = {
    libvirt = libvirt.host1
  }
}

module "k8s_vm_m2" {
  source = "../modules/libvirt_vm"
  
  # Set input variables here
  hostname = local.k8s_m2.hostname
  ipv4gw = var.k8s_common.ipv4gw
  ipv4mask = var.k8s_common.ipv4mask
  ipv6address = local.k8s_m1.ipv6address
  ipv6gw = var.k8s_common.ipv6gw
  ipv6mask = var.k8s_common.ipv6mask
  pool_path = local.k8s_m2.pool_path
  memory = var.k8s_common.memory
  vcpu = var.k8s_common.vcpu
  disk_size = var.k8s_common.disk_size
  bridgename = var.k8s_common.bridgename
  iso_path = var.k8s_common.iso_path
  volume_format = var.k8s_common.volume_format
  interface = var.k8s_common.interface

  # Required provider configuration
  providers = {
    libvirt = libvirt.host1
  }
}

module "k8s_vm_m3" {
  source = "../modules/libvirt_vm"
  
  # Set input variables here
  hostname = local.k8s_m3.hostname
  ipv4gw = var.k8s_common.ipv4gw
  ipv4mask = var.k8s_common.ipv4mask
  ipv6address = local.k8s_m1.ipv6address
  ipv6gw = var.k8s_common.ipv6gw
  ipv6mask = var.k8s_common.ipv6mask
  pool_path = local.k8s_m3.pool_path
  memory = var.k8s_common.memory
  vcpu = var.k8s_common.vcpu
  disk_size = var.k8s_common.disk_size
  bridgename = var.k8s_common.bridgename
  iso_path = var.k8s_common.iso_path
  volume_format = var.k8s_common.volume_format
  interface = var.k8s_common.interface

  # Required provider configuration
  providers = {
    libvirt = libvirt.host1
  }
}