variable "hosts_count" {
  description = "Number of the VMs"
  type        = number
  default     = 1
}

variable "Name" {
  description = "Name of the VM"
  type        = string
  default     = "ubuntu-vm"
}

variable "interface" {
  type = string
  default = "ens01"
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

variable "ipaddresses" {
  type = list
  default = ["192.168.40.61", "192.168.40.62", "192.168.40.63"]
}

variable "iso_path" {
  description = "Path to the Ubuntu 22.04 ISO file"
  type        = string
  default     = "/home/abasit/downloads/cloud-images/ubuntu-22-cloud-image/ubuntu22-disk.qcow2"
}

#variable "ssh_pub_key" {
#  description = "Public SSH key for the default user"
#  type        = string
#  default     = ""
#}
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
  type        = "string"
  default     = "~/.ssh/id_rsa"
  description = "The path to your private key"
}