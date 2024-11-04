#/home/dmlorren/upload_img.tf                                                                                                                                              386/386               100%


resource "yandex_storage_object" "image" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = local.bucket_name
  key    = "osen.jpg"
  source = "/home/dmlorren/osen.jpg"
  acl = "public-read"
  depends_on = [yandex_storage_bucket.dmlorren]
}
