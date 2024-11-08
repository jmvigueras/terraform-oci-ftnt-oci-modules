// Create new Fortigate VNC
module "fgt_vcn" {
  source           = "../../modules/vcn_fgt"
  compartment_ocid = var.compartment_ocid

  region     = var.region
  prefix     = local.prefix
  admin_cidr = local.admin_cidr
  admin_port = local.admin_port

  vcn_cidr = local.fgt_vcn_cidr
}
// Create FGT config
module "fgt_config" {
  source           = "../../modules/fgt_ha_config"
  tenancy_ocid     = var.tenancy_ocid
  compartment_ocid = var.compartment_ocid

  admin_cidr     = local.admin_cidr
  admin_port     = local.admin_port
  rsa_public_key = trimspace(tls_private_key.ssh.public_key_openssh)
  api_key        = random_string.api_key.result

  license_type   = local.license_type
  license_file_1 = local.license_file_1
  license_file_2 = local.license_file_2

  fgt_subnet_cidrs = module.fgt_vcn.fgt_subnet_cidrs
  fgt_1_ips        = module.fgt_vcn.fgt_1_ips
  fgt_2_ips        = module.fgt_vcn.fgt_2_ips

  config_fgcp = true

  vcn_spoke_cidrs = [local.spoke_vcn_cidr, module.fgt_vcn.fgt_subnet_cidrs["bastion"]]
}
// Create FGT instances
module "fgt" {
  source           = "../../modules/fgt_ha"
  compartment_ocid = var.compartment_ocid

  region = var.region
  prefix = local.prefix

  license_type = local.license_type

  fgt_config_1 = module.fgt_config.fgt_config_1
  fgt_config_2 = module.fgt_config.fgt_config_2

  fgt_vcn_id     = module.fgt_vcn.fgt_vcn_id
  fgt_subnet_ids = module.fgt_vcn.fgt_subnet_ids
  fgt_nsg_ids    = module.fgt_vcn.fgt_nsg_ids
  fgt_1_ips      = module.fgt_vcn.fgt_1_ips
  fgt_2_ips      = module.fgt_vcn.fgt_2_ips
  fgt_1_vnic_ips = module.fgt_vcn.fgt_1_vnic_ips
  fgt_2_vnic_ips = module.fgt_vcn.fgt_2_vnic_ips
}
module "fgt_lpg" {
  source = "../../modules/lpg"

  compartment_ocid = var.compartment_ocid
  prefix           = local.prefix

  vcn_id               = module.fgt_vcn.fgt_vcn_id
  rt_attach_subnet_ids = { "private" = module.fgt_vcn.fgt_subnet_ids["private"] }
  lpd_rt_id            = module.fgt.fgt_vcn_rt_to_fgt_id
}
// Create spoke VCN and attached to DRG
module "spoke_vcn" {
  source = "../../modules/vcn_spoke_peer"

  compartment_ocid = var.compartment_ocid
  prefix           = local.prefix

  admin_cidr     = local.admin_cidr
  vcn_cidr       = local.spoke_vcn_cidr
  fgt_vcn_lpg_id = module.fgt_lpg.lpd_id
}
// Create new test instance
module "spoke_vm" {
  source = "../../modules/vm"

  compartment_ocid = var.compartment_ocid
  prefix           = local.prefix

  subnet_id       = module.spoke_vcn.subnet_ids["vm"]
  authorized_keys = local.authorized_keys
}



#-----------------------------------------------------------------------
# Necessary variables
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
resource "local_file" "ssh_private_key_pem" {
  content         = tls_private_key.ssh.private_key_pem
  filename        = "./ssh-key/${local.prefix}-ssh-key.pem"
  file_permission = "0600"
}
locals {
  authorized_keys = [chomp(tls_private_key.ssh.public_key_openssh)]
}
# Create new random API key to be provisioned in FortiGates.
resource "random_string" "api_key" {
  length  = 30
  special = false
  numeric = true
}
