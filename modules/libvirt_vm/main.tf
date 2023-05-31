#create a new pool
resource "libvirt_pool" "k8s" {
  name = "k8s"
  type = "dir"
  path = "${var.pool_path}/${var.cluster_name}"
}

# We fetch the latest ubuntu release image from their mirrors
# use the default pool, already provisioned
resource "libvirt_volume" "base-qcow2" {
#  count  = var.vms_count
  name   = "${var.distro_name}_base.qcow2"
  pool   = libvirt_pool.k8s.name
  source = var.iso_path
  format = var.volume_format
}

resource "libvirt_volume" "ubuntu-qcow2" {
  count           = var.vms_count
  name            = "${var.hostnames[count.index]}_resized.qcow2"
  pool            = libvirt_pool.k8s.name
  base_volume_id  = libvirt_volume.base-qcow2.id
  size            = var.disk_size*1073741824
}

data "template_file" "user_data" {
  count    = var.vms_count
  template = file("${path.module}/config/cloud_init.yaml")
  vars = {
    host_name = var.hostnames[count.index]
    pub_key   = file(var.public_key)
  }
}

data "template_file" "network_config" {
  count    = var.vms_count
  template = file("${path.module}/config/network_config.yaml")
  vars = {
    ipv4_addr = var.ipv4addresses[count.index]
    ipv6_addr = var.ipv6addresses [count.index]
    interface_name = var.interface
  }
}

resource "libvirt_cloudinit_disk" "commoninit" {
  count          = var.vms_count
  name           = "commoninit-${var.hostnames[count.index]}.iso"
  user_data      = data.template_file.user_data[count.index].rendered
  network_config = data.template_file.network_config[count.index].rendered

  depends_on = [
    libvirt_volume.ubuntu-qcow2
  ]
}

# Create the machine
resource "libvirt_domain" "domain-ubuntu" {
  count  = var.vms_count
  name   = var.hostnames[count.index]
  memory = var.memory
  vcpu   = var.vcpu

  cloudinit = libvirt_cloudinit_disk.commoninit[count.index].id

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
    volume_id = libvirt_volume.ubuntu-qcow2[count.index].id
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

