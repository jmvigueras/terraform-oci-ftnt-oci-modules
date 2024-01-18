# Terraform Module: Local Peering Gateway

Create an OCI Local Peering Gateway (LPG)

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
| [oci_core_local_peering_gateway.fgt_vcn_lpg](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_local_peering_gateway) | resource |
| [oci_core_route_table.fgt_rt_private](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_route_table) | resource |
| [oci_core_route_table_attachment.fgt_rt_private_attachment](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_route_table_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_ocid"></a> [compartment\_ocid](#input\_compartment\_ocid) | OCI compartment ID | `any` | n/a | yes |
| <a name="input_fgt_subnet_ids"></a> [fgt\_subnet\_ids](#input\_fgt\_subnet\_ids) | Map of subnets IDss | `map(string)` | n/a | yes |
| <a name="input_fgt_vcn_id"></a> [fgt\_vcn\_id](#input\_fgt\_vcn\_id) | Fortigate VCN ID | `string` | n/a | yes |
| <a name="input_fgt_vcn_rt_to_fgt_id"></a> [fgt\_vcn\_rt\_to\_fgt\_id](#input\_fgt\_vcn\_rt\_to\_fgt\_id) | Fortigate VCN Route Table ID to create a route to new LPG ID | `string` | `null` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Resources prefix description | `string` | `"terraform"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Attribute for tag Enviroment | `map(any)` | <pre>{<br>  "project": "terraform"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fgt_vcn_lpg_id"></a> [fgt\_vcn\_lpg\_id](#output\_fgt\_vcn\_lpg\_id) | LPG ID |
<!-- END_TF_DOCS -->