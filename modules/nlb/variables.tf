variable "compartment_ocid" {
  description = "OCI compartment ID"
}

variable "prefix" {
  description = "Resources prefix description"
  type        = string
  default     = "terraform"
}


variable "tags" {
  description = "Attribute for tag Enviroment"
  type        = map(any)
  default = {
    project = "terraform"
  }
}

variable "subnet_id" {
  description = "iLB subnet ID"
  type        = string
  default     = null
}

variable "backend_ips" {
  description = "Fortigate instances IDs to configure backend listener"
  type        = map(string)
  default     = null
}

variable "nsg_ids" {
  description = "NLB Network Security Groups"
  type        = list(string)
  default     = null
}

variable "backend_port" {
  description = "Fortigates backend port used for health checks probes"
  type        = string
  default     = "8008"
}

variable "assigned_private_ipv4" {
  description = "Private IP address to assign to Internal NLB"
  type        = string
  default     = null
}

variable "load_balance_policy" {
  description = "Type of load balance criteria for backend server"
  type        = string
  default     = "FIVE_TUPLE"
}