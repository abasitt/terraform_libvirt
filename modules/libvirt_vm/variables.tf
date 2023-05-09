variable "vms_count" {
  description = "Number of the VMs"
  type        = number
  default     = 1
}

# to be removed
#variable "Name" {
#  description = "Name of the VM"
#  type        = string
#  default     = "ubuntu-vm"
#}

variable "interface" {
  type = string
  default = "ens01"
}

variable "bridgename" {
  type = string
  default = "virb0"
}

variable "memory" {
  description = "Memory for the VM"
  type        = number
  default     = 2048
}

variable "vcpu" {
  description = "Number of virtual CPUs for the VM"
  type        = number
  default     = 2
}

variable "ipv4addresses" {
  type = list
  default = ["192.168.255.61"]
}

variable "ipv6addresses" {
  type = list
  default = ["fc10::192:168:255:61"]
}

variable "iso_path" {
  description = "Path to the Ubuntu 22.04 ISO file"
  type        = string
  default     = "/home/abasit/downloads/cloud-images/ubuntu-22-cloud-image/ubuntu22-disk.qcow2"
}

variable "disk_size" {
  description = "Path to the Ubuntu 22.04 ISO file"
  type        = number
  default     = 20
}

#
#variable "macs" {
#  type = list
#  default = ["52:54:00:50:99:c5", "52:54:00:0e:87:be", "52:54:00:9d:90:38"]
#}
#
variable "hostnames" {
  type = list
  default = ["k8s-m1", "k8s-w1", "k8s-w2"]
}

variable "private_key" {
  type        = string
  default     = "~/.ssh/terraform_vm"
  description = "The path to your private key"
}

variable "public_key" {
  description = "Public SSH key for the default user"
  type        = string
  default     = "~/.ssh/terraform_vm.pub"
}

variable "pool_name" {
  type = string
  default = "default"
}

variable "volume_format" {
  type = string
  default = "qcow2"
}

variable "graphics_type" {
  type = string
  default = "spice"
}

variable "provision_script_path" {
  type    = string
  default = "path/to/provision_script.sh"
}
