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
    memory = 2048
    vcpu = 2
    disk_size = 30
    bridgename = "br40"
    pool_path = "/var/lib/libvirt/images"
    volume_format = "qcow2"
    iso_path = "/home/abasit/downloads/cloud-images/ubuntu-22-cloud-image/ubuntu22-disk.qcow2"
    interface = "eth0"
  }
}

# Local variables for k8s-m1 VM
locals {
  k8s_m1 = {
    hostname = "k8s-m1"
    ipv4address = "192.168.40.111"
    pool_path = "/mnt/dsk4tb1/kvm"
  }
}

# Local variables for k8s-m2 VM
locals {
  k8s_m2 = {
    hostname = "k8s-m2"
    ipv4address = "192.168.40.112"
  }
}

module "k8s_vm_m1" {
  source = "../modules/libvirt_vm"
  
  # Set input variables here
  hostname = local.k8s_m1.hostname
  ipv4address = local.k8s_m1.ipv4address
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
  ipv4address = local.k8s_m2.ipv4address
  pool_path = var.k8s_common.pool_path
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

