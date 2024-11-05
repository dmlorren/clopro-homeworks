#variables.tf 

variable "token" {
  type        = string
  default     = ""
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

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
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "public_subnet" {
  type        = string
  default     = "public-subnet"
  description = "subnet name"
}

### Variablables for KMS

variable "kms_key_name"  {
  type        = string
  default     = "kms-key"
}

variable "kms_key_description" {
  type        = string
  default     = "symmetric key for object storage"
}

variable "default_algorithm" {
  type        = string
  default     = "AES_128"
}

variable "prevent_destroy" {
  type        = bool
  default     = true
}

variable "sa_name" {
  type        = string
  default     = "sa-storage"
}

variable "student_name" {
  type        = string
  default     = "dmitriy1992"
}
