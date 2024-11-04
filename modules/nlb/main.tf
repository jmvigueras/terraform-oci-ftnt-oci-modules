# Create an internal Network Load Balancer
resource "oci_network_load_balancer_network_load_balancer" "i_nlb" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.prefix}-i-nlb"

  subnet_id  = var.subnet_id
  network_security_group_ids = var.nsg_ids

  is_private = true
  is_preserve_source_destination = true
  is_symmetric_hash_enabled = true
}

# Backend set for the load balancer, including backend instances
resource "oci_network_load_balancer_backend_set" "i_nlb_backend_set" {
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.i_nlb.id
  name                     = "${var.prefix}-backend-set"
  policy                   = var.load_balance_policy # Load balancing policy

  # Health checker for backend instances
  health_checker {
    protocol           = "TCP"
    port               = var.backend_port
    retries            = 3
    timeout_in_millis  = 1000 # 1 seconds
    interval_in_millis = 2000 # 2 seconds
  }

  is_fail_open                = true
  is_preserve_source          = true
  is_instant_failover_enabled = true
}

# Create NLB backend set servers
resource "oci_network_load_balancer_backend" "i_nlb_backends" {
  for_each   = { for k, v in var.backend_ips : k => v }

  backend_set_name         = oci_network_load_balancer_backend_set.i_nlb_backend_set.name
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.i_nlb.id
  
  name       = "${each.key}-${each.value}"
  ip_address = each.value
  port       = 0
}

# Listener for the load balancer
resource "oci_network_load_balancer_listener" "i_nlb_listener" {
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.i_nlb.id
  name                     = "${var.prefix}-http_listener"
  protocol                 = "ANY"
  port                     = 0
  default_backend_set_name = oci_network_load_balancer_backend_set.i_nlb_backend_set.name
}

# Fetch the NLB's private IP
data "oci_core_private_ips" "i_nlb_private_ip" {
  depends_on = [ oci_network_load_balancer_network_load_balancer.i_nlb ]

  subnet_id = var.subnet_id

  # Filter to find the private IP for the NLB's primary private IP
  filter {
    name   = "display_name"
    values = [oci_network_load_balancer_network_load_balancer.i_nlb.display_name]
  }
}
