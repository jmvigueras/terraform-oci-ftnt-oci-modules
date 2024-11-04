#------------------------------------------------------------------------------------------------------------
# Create LPG FGT VCN
#------------------------------------------------------------------------------------------------------------
// Create Local Peering Gateway
resource "oci_core_local_peering_gateway" "lpd" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.prefix}-fgt-lpg"
  vcn_id         = var.vcn_id

  route_table_id = var.lpd_rt_id
}
// Create Route Table pointing to LPG
resource "oci_core_route_table" "rt_to_lpd" {
  compartment_id = var.compartment_ocid
  vcn_id         = var.vcn_id
  display_name   = "${var.prefix}-rt-to-lpd"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_local_peering_gateway.lpd.id
  }
}
// Assign Route Table to LPG to subnets
resource "oci_core_route_table_attachment" "rt_to_lpd_attachs" {
  for_each = { for i, v in var.rt_attach_subnet_ids : i => v }

  subnet_id      = each.value
  route_table_id = oci_core_route_table.rt_to_lpd.id
}