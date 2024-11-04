# List of modules for OCI deployments

This is a collection of modules for OCI deployments. You can find an example of how to use each module in example folder. 

## List of modules
- [module drg](./modules/drg)
- [module fgt_config](./modules/fgt-config)
- [module fgt_ha](./modules/fgt-ha)
- [module ldp](./modules/ldp)
- [module nlb](./modules/nlb)
- [module vcn_fgt](./modules/vcn_fgt) 
- [module vcn_spoke_drg](./modules/vcn_spoke_drg)
- [module vcn_spoke_peer](./modules/vcn_spoke_peer)
- [module vm](./modules/vm)
      
## Deployment considerations:
   - Create file terraform.tfvars using terraform.tfvars.example as template 
   - Update variables in var.tf with fortigate cluster deployment
   - You will be charged for this deployment

## Requirements
* [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html) >= 0.12.0
* Check particulars requiriments for each deployment (AWS) 

# Support
This a personal repository with goal of testing and demo Fortinet solutions on the Cloud. No support is provided and must be used by your own responsability. Cloud Providers will charge for this deployments, please take it in count before proceed.

