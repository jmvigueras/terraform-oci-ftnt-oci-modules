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

variable "vcn_id" {
  description = "Fortigate VCN ID"
  type        = string
  default     = null
}

variable "rt_attach_subnet_ids" {
  description = "Map of subnets IDs"
  type        = map(string)
  default     = {}
}

variable "lpd_rt_id" {
  description = "LPD route table association"
  type        = string
  default     = null
}