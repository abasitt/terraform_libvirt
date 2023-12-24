variable "cluster_name" {
  type        = string
  description = "The name of the project"
  default     =  "k8s"
}


variable "vms_count" {
  description = "Number of the VMs"
  type        = number
  default     = 1
}


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

variable "autostart" {
  description = "Enable autostart for a VM"
  type        = string
  default     = "true"
}

variable "ipv4address" {
  type = string
  default = "192.168.255.61"
}

variable "ipv4mask" {
  type = string
  default = "24"
}

variable "ipv4gw" {
  type = string
  default = ""
}

variable "ipv6address" {
  type = string
  default = "fc10::192:168:255:61"
}

variable "ipv6mask" {
  type = string
  default = "64" 
}

variable "ipv6gw" {
  type = string
  default = ""
}

variable "iso_path" {
  description = "Path to the Ubuntu 22.04 ISO file"
  type        = string
  default     = "https://cloud-images.ubuntu.com/releases/jammy/release-20230302/ubuntu-22.04-server-cloudimg-amd64.img"
#  default     = "/home/abasit/downloads/cloud-images/ubuntu-22-cloud-image/ubuntu22-disk.qcow2"
}

variable "distro_name" {
  description = "Os distro name for base OS name"
  type        = string
  default     = "ubuntu"
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
variable "hostname" {
  type = string
  description = "hostname of the virtual machine"
  default = "k8s-m1"
}

variable "private_key" {
  type        = string
  default     = ""
  description = "The path to your private key"
}

variable "public_key" {
  description = "Public SSH key for the default user"
  type        = string
  default     = ""
}

variable "pool_path" {
  type        = string
  description = "The path for the libvirt pool"
  default     = "/var/lib/libvirt/images"
}


# to be remove
#variable "pool_name" {
#
#  type = string
#
#  default = "default"
#}

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
