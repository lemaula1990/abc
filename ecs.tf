provider "alicloud" {
  region = "cn-shanghai"
}

resource "alicloud_instance" "web" {
  instance_name = "web-server"
  instance_type = "ecs.t5-lc2m1.nano"
  image_id      = "ubuntu_18_04_64_20G_alibase_20190624.vhd"
  security_groups = ["sg-uf6f738vj1ktk9hkuolr"]
  vswitch_id    = "vsw-uf6bq77pudmj205fx09bw"
  internet_charge_type = "PayByTraffic"
  internet_max_bandwidth_out = 5
  system_disk_category = "cloud_efficiency"
  instance_charge_type = "PostPaid"
}


