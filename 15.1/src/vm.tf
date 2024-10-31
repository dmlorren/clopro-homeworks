#vm.tf


data "yandex_compute_image" "ubuntu" {
  family = var.vm_public_image
}

resource "yandex_compute_instance" "public" {
  name         = var.vm.public_vm.name
  zone         = var.vm.public_vm.zone
  platform_id  = var.vm.public_vm.platform_id
  resources {
    cores  = var.vm.public_vm.cores
    memory = var.vm.public_vm.memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  network_interface {
    subnet_id      = yandex_vpc_subnet.subnet_public.id
    nat            = var.vm.public_vm.nat_enable
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.ssh_public_key}"
  }
}

resource "yandex_compute_instance" "private" {
  name         = var.vm.private_vm.name
  zone         = var.vm.private_vm.zone
  platform_id  = var.vm.private_vm.platform_id
  resources {
    cores  = var.vm.private_vm.cores
    memory = var.vm.private_vm.memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  network_interface {
    subnet_id      = yandex_vpc_subnet.subnet_private.id
    nat            = var.vm.private_vm.nat_enable
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.ssh_public_key}"
  }
}