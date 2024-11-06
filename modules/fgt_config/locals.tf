locals {
  # fgt_id
  fgt_id = var.config_spoke ? "${var.spoke["id"]}-${var.fgt_id}" : var.config_hub ? "${var.hub[0]["id"]}-${var.fgt_id}" : var.fgt_id

  # -----------------------------------------------------------------------------------------------------
  # FGSP locals
  # -----------------------------------------------------------------------------------------------------
  # FGSP member ID
  fgsp_member_id = var.fgsp_member_id
  # List of FGSP peer ips
  fgsp_peer_ips = [
    for k, v in var.fgsp_member_ips : v if k != local.fgsp_member_id
  ] 
  # -----------------------------------------------------------------------------------------------------
  # AutoScale config
  # -----------------------------------------------------------------------------------------------------
  # AutoScale port name
  as_port_name = var.private_port
  # FGSP master is the member_id = 0 
  as_master_ip = var.fgsp_member_id == "0" ? "" : local.fgsp_peer_ips[0]
}