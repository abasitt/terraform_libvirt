terraform {
  cloud {
    hostname     = "app.terraform.io"
    organization = "abasit"

    workspaces {
      name = "k3sneo-libvirt"
    }
  }
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.1"
    }
  }
  required_version = ">= 0.13"
}

# Define providers
provider "libvirt" {
  alias = "host1"
  uri   = "qemu+ssh://abasit@192.168.10.5/system?keyfile=/home/abasit/.ssh/id_ed25519&no_verify=1"
}

provider "libvirt" {
  alias = "host2"
  uri   = "qemu+ssh://abasit@192.168.10.7/system?keyfile=/home/abasit/.ssh/id_ed25519&no_verify=1"
}

provider "libvirt" {
  alias = "host3"
  uri   = "qemu+ssh://abasit@192.168.10.8/system?keyfile=/home/abasit/.ssh/id_ed25519&no_verify=1"
}