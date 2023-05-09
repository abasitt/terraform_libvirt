
#module "k8s_vm" {
#  source = "./modules/libvirt_vm"
#  
#  # Set input variables here
#  # For example:
#  hostnames = ["k8s-m1","k8s-m2"]
#  ipv4addresses = ["192.168.40.111","192.168.40.112"]
#  memory = 2048
#  vcpu = 2
#  bridgename = "br40"
#  vms_count = 2
#  #iso_path = "http://archive.ubuntu.com/ubuntu/dists/bionic-updates/main/installer-amd64/current/images/netboot/mini.iso"
#  pool_name = "default"
#  volume_format = "qcow2"
#  interface = "ens3"
#  # Required provider configuration
#  providers = {
#    libvirt = libvirt.host1
#  }
#}

# Global variables
variable "k8s_common" {
  default = {
    memory = 2048
    vcpu = 2
    disk_size = 30
    bridgename = "br40"
    pool_name = "default"
    volume_format = "qcow2"
    interface = "eth0"
  }
}

# Local variables for k8s-m1 VM
locals {
  k8s_m1 = {
    hostname = "k8s-m1"
    ipv4address = "192.168.40.111"
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
  source = "./modules/libvirt_vm"
  
  # Set input variables here
  hostnames = [local.k8s_m1.hostname]
  ipv4addresses = [local.k8s_m1.ipv4address]
  memory = var.k8s_common.memory
  vcpu = var.k8s_common.vcpu
  disk_size = var.k8s_common.disk_size
  bridgename = var.k8s_common.bridgename
  pool_name = var.k8s_common.pool_name
  volume_format = var.k8s_common.volume_format
  interface = var.k8s_common.interface

  # Required provider configuration
  providers = {
    libvirt = libvirt.host1
  }
}

module "k8s_vm_m2" {
  source = "./modules/libvirt_vm"
  
  # Set input variables here
  hostnames = [local.k8s_m2.hostname]
  ipv4addresses = [local.k8s_m2.ipv4address]
  memory = var.k8s_common.memory
  vcpu = var.k8s_common.vcpu
  disk_size = var.k8s_common.disk_size
  bridgename = var.k8s_common.bridgename
  pool_name = var.k8s_common.pool_name
  volume_format = var.k8s_common.volume_format
  interface = var.k8s_common.interface

  # Required provider configuration
  providers = {
    libvirt = libvirt.host1
  }
}

