# Terraform Module: Spoke VCN attached to DRG

Create a Virtual Cloud Network (VCN) spoke attached to a DRG

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_core_drg_attachment.drg_attach_vcn_spoke](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_drg_attachment) | resource |
| [oci_core_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_internet_gateway) | resource |
| [oci_core_route_table.rt_to_drg_default](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_route_table) | resource |
| [oci_core_route_table.rt_to_drg_rfc1918](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_route_table) | resource |
| [oci_core_security_list.sl_vm](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_security_list) | resource |
| [oci_core_subnet.subnet_vm](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_subnet) | resource |
| [oci_core_virtual_network.vcn](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_cidr"></a> [admin\_cidr](#input\_admin\_cidr) | n/a | `string` | `"0.0.0.0/0"` | no |
| <a name="input_compartment_ocid"></a> [compartment\_ocid](#input\_compartment\_ocid) | n/a | `any` | n/a | yes |
| <a name="input_drg_id"></a> [drg\_id](#input\_drg\_id) | DRG ID | `string` | `null` | no |
| <a name="input_drg_rt_id"></a> [drg\_rt\_id](#input\_drg\_rt\_id) | DRG Route Table ID (pre-inspection) | `string` | `null` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | OCI resourcers prefix description | `string` | `"terraform"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"eu-frankfurt-1"` | no |
| <a name="input_region_ad_1"></a> [region\_ad\_1](#input\_region\_ad\_1) | n/a | `string` | `"1"` | no |
| <a name="input_region_ad_2"></a> [region\_ad\_2](#input\_region\_ad\_2) | n/a | `string` | `"2"` | no |
| <a name="input_sufix"></a> [sufix](#input\_sufix) | n/a | `string` | `"1"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Resouce Tags | `map(string)` | <pre>{<br>  "owner": "terraform",<br>  "project": "terraform-deploy"<br>}</pre> | no |
| <a name="input_vcn_cidr"></a> [vcn\_cidr](#input\_vcn\_cidr) | # VCN and SUBNET ADDRESSESS | `string` | `"172.20.0.0/24"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | n/a |
| <a name="output_vcn_id"></a> [vcn\_id](#output\_vcn\_id) | n/a |
<!-- END_TF_DOCS -->