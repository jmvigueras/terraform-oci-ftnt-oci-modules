// local variables
locals {
  prefix = "demo-fgt-ha-nlb"

  admin_cidr = "0.0.0.0/0"
  admin_port = "8443"
  vcn_cidr   = "172.20.0.0/24"

  license_type = "payg"

  spokes_cidrs = ["172.20.100.0/24", "172.20.150.0/24"]
}