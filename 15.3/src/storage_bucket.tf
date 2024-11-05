#storage_bucket.tf 

locals {
    current_timestamp = timestamp()
    formatted_date = formatdate("DD-MM-YYYY", local.current_timestamp)
    bucket_name = "dmlorren-${local.formatted_date}"
}

resource "yandex_iam_service_account" "sa" {
  name = var.sa_name
}

resource "yandex_resourcemanager_folder_iam_member" "sa-admin" {
  folder_id = var.folder_id
  role      = "storage.admin"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
  depends_on = [yandex_iam_service_account.sa]
}

resource "yandex_resourcemanager_folder_iam_member" "sa-storage-put" {
  folder_id = var.folder_id
  role      = "storage.uploader"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
  depends_on = [yandex_iam_service_account.sa]
}

resource "yandex_resourcemanager_folder_iam_member" "sa-editor-encrypter-decrypter" {
  folder_id = var.folder_id
  role      = "kms.keys.encrypterDecrypter"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
  depends_on = [yandex_iam_service_account.sa]

}

resource "yandex_kms_symmetric_key" "key-a" {
  name              = var.kms_key_name
  description       = var.kms_key_description
  default_algorithm = var.default_algorithm
  lifecycle {
    prevent_destroy = false
  }
}

resource "yandex_iam_service_account_static_access_key" "static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

resource "yandex_storage_bucket" "dmlorren" {
  access_key            = yandex_iam_service_account_static_access_key.static-key.access_key
  secret_key            = yandex_iam_service_account_static_access_key.static-key.secret_key
  bucket                = local.bucket_name
  acl                   = "public-read"
  server_side_encryption_configuration {
         rule {
           apply_server_side_encryption_by_default {
             kms_master_key_id = yandex_kms_symmetric_key.key-a.id
             sse_algorithm     = "aws:kms"
       }
     }
   }
}

resource "yandex_storage_object" "osen" {
   access_key = yandex_iam_service_account_static_access_key.static-key.access_key
   secret_key = yandex_iam_service_account_static_access_key.static-key.secret_key
   bucket = local.bucket_name
   key    = "osen.jpg"
   source = "/home/dmlorren/osen.jpg"
   acl = "public-read"
   depends_on = [yandex_storage_bucket.dmlorren]
}