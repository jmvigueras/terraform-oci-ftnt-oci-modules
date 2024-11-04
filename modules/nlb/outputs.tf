output "i_nlb_id" {
  description = "Internal Network Load Balancer ID"
  value       = oci_network_load_balancer_network_load_balancer.i_nlb.id
}

output "i_nlb_ip_address" {
  description = "Internal Network Load Balancer IP Address"
  value       = data.oci_core_private_ips.i_nlb_private_ip.private_ips[0].ip_address
}

output "i_nlb_ip_id" {
  description = "Internal Network Load Balancer IP Address ID"
  value       = data.oci_core_private_ips.i_nlb_private_ip.private_ips[0].id
}