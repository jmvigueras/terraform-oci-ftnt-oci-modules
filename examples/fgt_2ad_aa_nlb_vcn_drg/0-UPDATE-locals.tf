// local variables
locals {
  prefix = "fgt-aa-nlb"

  admin_cidr   = "0.0.0.0/0"
  admin_port   = "8443"
  license_type = "payg"
  config_fgsp  = true

  vcn_cidr     = "172.20.0.0/24"
  spokes_cidrs = ["172.20.100.0/24", "172.20.150.0/24"]
}