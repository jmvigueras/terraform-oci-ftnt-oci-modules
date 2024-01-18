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

variable "fgt_vcn_id" {
  description = "Fortigate VCN ID"
  type        = string
}

variable "fgt_subnet_ids" {
  description = "Map of subnets IDss"
  type        = map(string)
}

variable "fgt_vcn_rt_to_fgt_id" {
  description = "Fortigate VCN Route Table ID to create a route to new LPG ID"
  type        = string
  default     = null
}