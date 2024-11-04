# Forigate cluster deployment

This deployment will create a Fortigate Cluster Active/Passive in two Availability Domains (AD1 and AD2) and with 3 ports (Management-HA, Public and Private). A Network Load Balancer (NLB) will stear the traffic comming from Dynamic Routing Gateway (DRG) to the cluster. NLB will only have one backend corresponding to the floating IP of the FortiGates cluster, that will move to one member to other by the SDN connector in case of failover. With this setup, active sessions will not be reset by the NLB in case of failover.  

## Deployment Overview

- New VCN with necessary regional subnets: Management (MGMT), Public and Private.
- Fortigate cluster: 2 instances with 3 interfaces in active-passive cluster FGCP.
- OCI NLB with one backend been floating IP of FortiGates cluster.

## Requirements
* [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html) >= 1.0.0
* Check particulars requiriments for each deployment (OCI) 

## Deployment
* Clone the repository.
* Configure accesss secrets to access OCI in terraform.tfvars.example which is allocated in root folder. [terraform.tfvars.example](./terraform.tfvars.example).  And rename `terraform.tfvars.example` to `terraform.tfvars`.
* Change parameters in the variables.tf.
* If using SSO, uncomment the token variable in variables.tf and providers.tf
* Initialize the providers and modules in each individual deployment as is described in it README file.

# Support
This a personal repository with goal of testing and demo Fortinet solutions on the Cloud. No support is provided and must be used by your own responsability. Cloud Providers will charge for this deployments, please take it in count before proceed.

