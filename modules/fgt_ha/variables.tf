variable "compartment_ocid" {
  description = "OCI compartment ID"
}

variable "tenancy_ocid" {
  description = "OCI Tenancy ID"
  type        = string
  default     = ""
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

variable "region" {
  description = "OCI region to deploy fortigate instances"
  type        = string
  default     = "eu-frankfurt-1"
}

variable "region_ad_1" {
  description = "OCI region Availability Domain 1"
  type        = string
  default     = "1"
}

variable "region_ad_2" {
  description = "OCI region Availability Domain 2"
  type        = string
  default     = "2"
}

variable "fgt_passive" {
  description = "Booolean to create Fortigate passive instance"
  type        = bool
  default     = false
}

variable "fgt_ha_fgsp" {
  description = "Boolean to define Fortigate cluster as FGSP"
  type        = bool
  default     = false
}

variable "fgt_config_1" {
  description = "Fotigate 1 bootstrap config"
  type        = string
  default     = ""
}

variable "fgt_config_2" {
  description = "Fotigate 1 bootstrap config"
  type        = string
  default     = ""
}

variable "fgt_image_ids" {
  description = "Fortigate image IDs either BYOL or PAYG"
  type        = map(string)
  default = {
    byol = "ocid1.image.oc1..aaaaaaaalj3fxkjxnru4i5725rl45iur3ducp5fy5dmulwzjtepathmtxbta"
    payg = "ocid1.image.oc1..aaaaaaaatwwtthsopj6iqfg762xpwnsmsnuzwhpwad7lw6slfjrao2f3bnha"
  }
}

variable "instance_shape" {
  description = "Oracle instance types"
  type        = string
  default     = "VM.Standard2.4"
  // default = "VM.Standard.E4.Flex"
}

variable "volume_size" {
  description = "Default secondary disk size"
  default     = "50" //GB
}

variable "fgt_ni_0" {
  description = "Index 0 instace interface type of port"
  type        = string
  default     = "public"
}
variable "fgt_ni_1" {
  description = "Index 1 instace interface type of port"
  type        = string
  default     = "private"
}
variable "fgt_ni_2" {
  description = "Index 2 instace interface type of port"
  type        = string
  default     = "mgmt"
}
variable "fgt_ni_3" {
  description = "Index 3 instace interface type of port"
  type        = string
  default     = "ha"
}

variable "license_type" {
  description = "Provide the license type for FortiGate-VM Instances, either byol or payg"
  type        = string
  default     = "payg"
}

variable "fgt_subnet_ids" {
  description = "Fortigate subnets IDs map"
  type        = map(string)
  default     = null
}

variable "fgt_vcn_id" {
  description = "Orace VCN where deploy Fortigate instances"
  type        = string
  default     = null
}

variable "fgt_1_ips" {
  description = "Fortigate 1 map of IPs of each port"
  type        = map(string)
  default     = null
}

variable "fgt_1_vnic_ips" {
  description = "Fortigate 1 instance map of IPs of each network interface"
  type        = map(string)
  default     = null
}

variable "fgt_2_vnic_ips" {
  description = "Fortigate 2 instance map of IPs of each network interface"
  type        = map(string)
  default     = null
}

variable "fgt_2_ips" {
  description = "Fortigate 2 map of IPs of each port"
  type        = map(string)
  default     = null
}

variable "public_ip_lifetime" {
  description = "Type of public IPs"
  type        = string
  default     = "RESERVED"
  //or EPHEMERAL
}

variable "fgt_nsg_ids" {
  description = "Map of security groups to assign"
  type        = map(string)
  default     = null
}

variable "ocpus" {
  description = "OCI instance number of CPUs, used if type of instance is flex"
  type        = number
  default     = 4
}

variable "memory_in_gbs" {
  description = "OCI instance GBp of RAM memory, used if type of instance is flex"
  type        = number
  default     = 16
}
