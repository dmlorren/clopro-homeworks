#/home/dmlorren/vpc_local.tf                                                                                                          376/376               100%

locals {
  ssh-keys = file("/root/.ssh/id_ed25519.pub")
  ssh-private-keys = file("/root/.ssh/id_ed25519")
}

resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "public" {
  name           = var.public_subnet
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}
