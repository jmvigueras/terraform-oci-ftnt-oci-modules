#-----------------------------------------------------------------------
# Deploy FortiGates VCN with NLB
#-----------------------------------------------------------------------
// Create new VNC
module "fgt_vcn" {
  source           = "../../modules/vcn_fgt"
  compartment_ocid = var.compartment_ocid

  region     = var.region
  prefix     = local.prefix
  admin_cidr = local.admin_cidr
  admin_port = local.admin_port

  vcn_cidr = local.vcn_cidr
}
// Create FGT config
module "fgt_config" {
  source           = "../../modules/fgt_config"
  tenancy_ocid     = var.tenancy_ocid
  compartment_ocid = var.compartment_ocid

  admin_cidr     = local.admin_cidr
  admin_port     = local.admin_port
  rsa_public_key = trimspace(tls_private_key.ssh.public_key_openssh)
  api_key        = random_string.api_key.result

  license_type = local.license_type

  fgt_subnet_cidrs = module.fgt_vcn.fgt_subnet_cidrs
  fgt_1_ips        = module.fgt_vcn.fgt_1_ips //use fgt_1_ips for HA with SDN connector of NLB with floating IP as backend
  fgt_2_ips        = module.fgt_vcn.fgt_2_ips //use fgt_2_vcn_ips for NLB with two fortigates as backend

  config_fgcp = true
}
// Create FGT instances
module "fgt" {
  source           = "../../modules/fgt_ha"
  compartment_ocid = var.compartment_ocid

  region = var.region
  prefix = local.prefix

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
// Create Internal NLB
module "nlb" {
  depends_on       = [module.fgt]
  source           = "../../modules/nlb"
  compartment_ocid = var.compartment_ocid

  prefix = local.prefix

  subnet_id = module.fgt_vcn.fgt_subnet_ids["private"]
  nsg_ids   = [module.fgt_vcn.fgt_nsg_ids["private"]]

  load_balance_policy = "TWO_TUPLE"
  backend_ips = {
    "fgt1" = module.fgt_vcn.fgt_1_ips["private"]
  }
}
// Create Route Table to point default to NLB
resource "oci_core_route_table" "rt_to_nlb" {
  compartment_id = var.compartment_ocid
  vcn_id         = module.fgt_vcn.fgt_vcn_id
  display_name   = "${local.prefix}-rt-to-nlb"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = module.nlb.i_nlb_ip_id
  }
}

#-----------------------------------------------------------------------
# Create HUB-SPOKE VCNs topology with DRG
#-----------------------------------------------------------------------
// Create new DRG
module "drg" {
  depends_on = [module.fgt_vcn, module.fgt]
  source     = "../../modules/drg"

  compartment_ocid = var.compartment_ocid
  prefix           = local.prefix

  fgt_vcn_id        = module.fgt_vcn.fgt_vcn_id
  fgt_vcn_rt_drg_id = oci_core_route_table.rt_to_nlb.id
  fgt_subnet_ids    = module.fgt_vcn.fgt_subnet_ids
}
// Create spoke VCN and attached to DRG
module "spoke_vcns" {
  source = "../../modules/vcn_spoke_drg"

  for_each = { for i, v in local.spokes_cidrs : i => v }

  compartment_ocid = var.compartment_ocid
  prefix           = local.prefix
  sufix            = each.key + 1

  admin_cidr = local.admin_cidr
  vcn_cidr   = each.value
  drg_id     = module.drg.drg_id
  drg_rt_id  = module.drg.drg_rt_ids["pre"]
}
// Create new test instance
module "spoke_vms" {
  source = "../../modules/vm"

  for_each = { for i, v in local.spokes_cidrs : i => v }

  compartment_ocid = var.compartment_ocid
  prefix           = "${local.prefix}-spoke${each.key + 1}"

  subnet_id       = module.spoke_vcns[each.key].subnet_ids["vm"]
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
