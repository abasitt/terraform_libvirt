
module "k8s_vm" {
  source = "./modules/libvirt_vm"
  
  # Set input variables here
  # For example:
  hostnames = ["k8s-m1","k8s-m2"]
  ipv4addresses = ["192.168.40.111","192.168.40.112"]
  memory = 2048
  vcpu = 2
  bridgename = "br40"
  vms_count = 2
  #iso_path = "http://archive.ubuntu.com/ubuntu/dists/bionic-updates/main/installer-amd64/current/images/netboot/mini.iso"
  pool_name = "default"
  volume_format = "qcow2"
  interface = "ens3"
  # Required provider configuration
  providers = {
    libvirt = libvirt.host1
  }
}
