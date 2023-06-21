#create a new pool
resource "libvirt_pool" "k8spool" {
  name  = "k8spool_${var.hostname}"
  type  = "dir"
  path  = "${var.pool_path}/${var.hostname}"
}

# Base image, currently created for each VM, need to fix to have a common image per host
resource "libvirt_volume" "base-qcow2" {
  name   = "${var.distro_name}_base.qcow2"
  pool   = libvirt_pool.k8spool.name
  source = var.iso_path
  format = var.volume_format
}

resource "libvirt_volume" "ubuntu-qcow2" {
  name            = "${var.hostname}_resized.qcow2"
  pool            = libvirt_pool.k8spool.name
  base_volume_id  = libvirt_volume.base-qcow2.id
  size            = var.disk_size*1073741824
}

data "template_file" "user_data" {
  template = file("${path.module}/config/cloud_init.yaml")
  vars = {
    host_name = var.hostname
    pub_key   = file(var.public_key)
  }
}

data "template_file" "network_config" {
  template = file("${path.module}/config/network_config.yaml")
  vars = {
    ipv4_addr = var.ipv4address
    ipv6_addr = var.ipv6address
    interface_name = var.interface
  }
}

resource "libvirt_cloudinit_disk" "commoninit" {
  name           = "commoninit-${var.hostname}.iso"
  user_data      = data.template_file.user_data.rendered
  network_config = data.template_file.network_config.rendered
  pool           = libvirt_pool.k8spool.name
  depends_on = [
    libvirt_volume.ubuntu-qcow2
  ]
}

# Create the machine
resource "libvirt_domain" "domain-ubuntu" {
  name      = var.hostname
  memory    = var.memory
  vcpu      = var.vcpu
  autostart = var.autostart

  cloudinit = libvirt_cloudinit_disk.commoninit.id

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = libvirt_volume.ubuntu-qcow2.id
  }

  network_interface {
    bridge = var.bridgename
  }

  graphics {
    type        = var.graphics_type
    listen_type = "address"
    autoport    = true
  }

  #provisioner "remote-exec" {
  #  inline = [
  #    "sudo netplan apply",
  #  ]
  #}

  #depends_on = [
  #  libvirt_cloudinit_disk.commoninit
  #]

}

