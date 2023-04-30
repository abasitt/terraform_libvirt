#since default pool is already available at /var/lib/libvirt/images, we will skip pool creation part
#resource "libvirt_pool" "ubuntu" {
#  name = "ubuntu"
#  type = "dir"
#  path = "/var/lib/libvirt/images"
#}

# We fetch the latest ubuntu release image from their mirrors
# use the default pool, already provisioned
resource "libvirt_volume" "ubuntu-qcow2" {
  count  = length(var.hostnames)
  name   = "${var.hostnames[count.index]}.qcow2"
  pool   = "default"
  source = var.iso_path
  format = "qcow2"
}


data "template_file" "user_data" {
  count    = length(var.hostnames)
  template = file("${path.module}/config/cloud_init.yaml")
  vars = {
    host_name = var.hostnames[count.index]
  }
}

data "template_file" "network_config" {
  count    = length(var.ipaddresses)
  template = file("${path.module}/config/network_config.yaml")
  vars = {
    ip_addr = var.ipaddresses[count.index]
    interface_name = var.interface
  }
}

resource "libvirt_cloudinit_disk" "commoninit" {
  count = length(var.hostnames)
  name           = "commoninit-${var.hostnames[count.index]}.iso"
  user_data      = data.template_file.user_data[count.index].rendered
  network_config = data.template_file.network_config[count.index].rendered
}

# Create the machine
resource "libvirt_domain" "domain-ubuntu" {
  count  = var.hosts_count
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
    bridge = "br40"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }

  #provisioner "remote-exec" {
  #  inline = [
  #    "sudo netplan apply",
  #  ]
  #}

}

