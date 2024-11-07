provider "alicloud" { 

  region = "cn-shanghai" 

} 

resource "alicloud_vpc" "vpc" { 

  vpc_name   = "tf_test_vpc" 

  cidr_block = "172.16.0.0/16" 

} 

resource "alicloud_vswitch" "vsw" { 

  vpc_id     = alicloud_vpc.vpc.id 

  cidr_block = "172.16.0.0/21" 

  zone_id    = "cn-shanghai-b"  # Updated to a supported zone in Shanghai 

} 

resource "alicloud_security_group" "tf_test_sg" { 

  name   = "tf_test_sg" 

  vpc_id = alicloud_vpc.vpc.id 

} 

resource "alicloud_db_instance" "rds" { 

  engine           = "MySQL" 

  engine_version   = "5.7" 

  instance_type    = "rds.mysql.t1.small"  # Free-tier eligible instance type 

  instance_storage = 20                    # Minimum storage size for free-tier 

  vswitch_id       = alicloud_vswitch.vsw.id 

  security_group_ids = [alicloud_security_group.tf_test_sg.id]  # Use list for security group IDs 

  instance_name    = "tf_test_db" 

  instance_charge_type = "Postpaid"        # Correct value for pay-as-you-go billing method 

} 

resource "alicloud_db_database" "db" { 

  instance_id = alicloud_db_instance.rds.id 

  name        = "tf_test_db" 

  character_set = "utf8" 

} 

resource "alicloud_db_account" "account" { 

  db_instance_id = alicloud_db_instance.rds.id 

  account_name   = "dbadmin" 

  account_password = "P@ssw0rd" 

} 

resource "alicloud_db_account_privilege" "privilege" { 

  instance_id  = alicloud_db_instance.rds.id 

  account_name = alicloud_db_account.account.account_name 

  db_names     = [alicloud_db_database.db.name] 

  privilege    = "ReadWrite"  # Correct argument name 

} 
