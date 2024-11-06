// local variables
locals {
  prefix = "fgt-aaa-nlb"

  admin_cidr   = "0.0.0.0/0"
  admin_port   = "8443"
  license_type = "payg"
  config_fgsp  = true

  vcn_cidr     = "172.20.0.0/24"
  spokes_cidrs = ["172.20.100.0/24", "172.20.150.0/24"]
}

#-----------------------------------------------------------------------------------------------------
# FGT FGSP variables
#-----------------------------------------------------------------------------------------------------
locals {
  subnet_cidr_host    = 5
  fgsp_cluster_number = 3

  fgt_subnet_cidrs = module.fgt_vcn.fgt_subnet_cidrs
  # Map of ips of each FGSP cluster members
  fgsp_member_ips = { for i in range(0, local.fgsp_cluster_number) :
    i => cidrhost(local.fgt_subnet_cidrs["private"], local.subnet_cidr_host + i)
  }
  # Map of IPs for each fortigate
  fgt_ips = { for i in range(0, local.fgsp_cluster_number) : i => {
    "public"  = cidrhost(local.fgt_subnet_cidrs["public"], local.subnet_cidr_host + i),
    "private" = cidrhost(local.fgt_subnet_cidrs["private"], local.subnet_cidr_host + i)
    }
  }
}