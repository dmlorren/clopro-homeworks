#variables.tf 


variable "cloud_id" {
  type        = string
  default     = " "
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = " "
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "public_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_public_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image OS"
}

variable "vpc_network" {
  type = map(object({
    name        = string
    cidr        = list(string)
    zone        = string
  }))
  default = {
    public = {
      name        = "public-dmlorren"
      cidr        = ["192.168.10.0/24"]
      zone        = "ru-central1-a"
    }
    private = {
      name        = "private-dmlorren"
      cidr        = ["192.168.20.0/24"]
      zone        = "ru-central1-a"
    }
  }
}

variable "destination_route"{
  type = string
  default = "0.0.0.0/0"
}

variable "nat_instance" {
  type = map(object({
    name        = string
    platform_id = string
    zone        = string
    image_id    = string
    ip_address  = string
    cores       = number
    memory      = number
    nat_enable  = bool
  }))
  default = {
    nat = {
      name        = "nat-instance"
      platform_id = "standard-v2"
      zone        = "ru-central1-a"
      image_id    = "fd80mrhj8fl2oe87o4e1"
      ip_address  = "192.168.10.254"
      cores       = 2
      memory      = 4
      nat_enable  = true
    }
  }
}

variable "vm" {
  type = map(object({
    name        = string
    platform_id = string
    zone        = string
    cores       = number
    memory      = number
    nat_enable  = bool
  }))
  default = {
    public_vm = {
      name        = "public-vm"
      platform_id = "standard-v2"
      zone        = "ru-central1-a"
      cores       = 2
      memory      = 4
      nat_enable  = true
    }
    private_vm = {
      name        = "private-vm"
      platform_id = "standard-v2"
      zone        = "ru-central1-a"
      cores       = 2
      memory      = 4
      nat_enable  = false
    }
  }
}
