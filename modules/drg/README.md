# Terraform Module: Dynamic Routing Gateway

Create an OCI Dynamic Routing Gateway (DRG)

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
| [oci_core_drg.drg](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_drg) | resource |
| [oci_core_drg_attachment.drg_attach_vcn_fgt](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_drg_attachment) | resource |
| [oci_core_drg_route_distribution.drg_route_distribution](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_drg_route_distribution) | resource |
| [oci_core_drg_route_distribution_statement.drg_route_distribution_statement](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_drg_route_distribution_statement) | resource |
| [oci_core_drg_route_table.drg_rt_post_inspection](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_drg_route_table) | resource |
| [oci_core_drg_route_table.drg_rt_pre_inspection](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_drg_route_table) | resource |
| [oci_core_drg_route_table_route_rule.drg_rt_pre_inspection_rule](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_drg_route_table_route_rule) | resource |
| [oci_core_route_table.fgt_rt_private](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_route_table) | resource |
| [oci_core_route_table_attachment.fgt_rt_private_attachment](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_route_table_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_ocid"></a> [compartment\_ocid](#input\_compartment\_ocid) | OCI compartment ID | `any` | n/a | yes |
| <a name="input_fgt_subnet_ids"></a> [fgt\_subnet\_ids](#input\_fgt\_subnet\_ids) | Map of subnets IDss | `map(string)` | n/a | yes |
| <a name="input_fgt_vcn_id"></a> [fgt\_vcn\_id](#input\_fgt\_vcn\_id) | Fortigate VCN ID | `string` | n/a | yes |
| <a name="input_fgt_vcn_rt_drg_id"></a> [fgt\_vcn\_rt\_drg\_id](#input\_fgt\_vcn\_rt\_drg\_id) | Fortigate VCN Route Table ID to create a route to new DRG ID | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Resources prefix description | `string` | `"terraform"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Attribute for tag Enviroment | `map(any)` | <pre>{<br>  "project": "terraform"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_drg_default_route_table_id_vcn"></a> [drg\_default\_route\_table\_id\_vcn](#output\_drg\_default\_route\_table\_id\_vcn) | OCI DRG default route table ID |
| <a name="output_drg_default_route_table_ids"></a> [drg\_default\_route\_table\_ids](#output\_drg\_default\_route\_table\_ids) | OCI DRG default Route Tables IDs |
| <a name="output_drg_id"></a> [drg\_id](#output\_drg\_id) | OCI DRG ID |
| <a name="output_drg_rt_ids"></a> [drg\_rt\_ids](#output\_drg\_rt\_ids) | OCI DRG pre and post inspection created Route Tables IDs |
<!-- END_TF_DOCS -->