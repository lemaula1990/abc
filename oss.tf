provider "alicloud" {
  region = "cn-shanghai"
}

resource "alicloud_oss_bucket" "bucket" {
  bucket = "my-oss-bucket"
  acl    = "private"
}
