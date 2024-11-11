provider "alicloud" {
  region = "cn-shanghai"
}

resource "alicloud_slb" "load_balancer" {
  name = "my-load-balancer"
}

resource "alicloud_slb_listener" "http" {
  load_balancer_id = alicloud_slb.load_balancer.id
  backend_port     = 80
  frontend_port    = 80
  protocol         = "http"
}
