terraform {
 required_version = ">= 0.13"
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.1"
    }
  }
}

# Define providers
provider "libvirt" {
  alias = "host1"
  uri   = "qemu+ssh://abasit@192.168.10.5/system"
}

provider "libvirt" {
  alias = "host2"
  uri   = "qemu+ssh://abasit@192.168.10.6/system"
}

provider "libvirt" {
  alias = "host3"
  uri   = "qemu+ssh://abasit@192.168.10.7/system"
}