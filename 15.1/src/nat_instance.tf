# cat nat_instance.tf 

resource "yandex_compute_instance" "nat_instance" {
  name         = var.nat_instance.nat.name
  zone         = var.nat_instance.nat.zone
  platform_id  = var.nat_instance.nat.platform_id
  resources {
    cores  = var.nat_instance.nat.cores
    memory = var.nat_instance.nat.memory
  }
  
  boot_disk {
    initialize_params {
      image_id = var.nat_instance.nat.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_public.id
    nat       = var.nat_instance.nat.nat_enable
    ip_address = var.nat_instance.nat.ip_address 
  }
}