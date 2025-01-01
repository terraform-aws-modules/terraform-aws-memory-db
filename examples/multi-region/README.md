# Multi Region cluster

Configuration in this directory creates:

- AWS Multi-Regional MemoryDB cluster
- AWS MemoryDB cluster
- AWS MemoryDB users
- AWS MemoryDB ACL
- AWS MemoryDB subnet group

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.82 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_memory_db"></a> [memory\_db](#module\_memory\_db) | ../.. | n/a |
| <a name="module_memory_db_disabled"></a> [memory\_db\_disabled](#module\_memory\_db\_disabled) | ../.. | n/a |
| <a name="module_multi_region_cluster"></a> [multi\_region\_cluster](#module\_multi\_region\_cluster) | ../../modules/multi-region-cluster | n/a |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | terraform-aws-modules/security-group/aws | ~> 4.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acl_arn"></a> [acl\_arn](#output\_acl\_arn) | The ARN of the ACL |
| <a name="output_acl_id"></a> [acl\_id](#output\_acl\_id) | Name of the ACL |
| <a name="output_acl_minimum_engine_version"></a> [acl\_minimum\_engine\_version](#output\_acl\_minimum\_engine\_version) | The minimum engine version supported by the ACL |
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | The ARN of the cluster |
| <a name="output_cluster_endpoint_address"></a> [cluster\_endpoint\_address](#output\_cluster\_endpoint\_address) | DNS hostname of the cluster configuration endpoint |
| <a name="output_cluster_endpoint_port"></a> [cluster\_endpoint\_port](#output\_cluster\_endpoint\_port) | Port number that the cluster configuration endpoint is listening on |
| <a name="output_cluster_engine_patch_version"></a> [cluster\_engine\_patch\_version](#output\_cluster\_engine\_patch\_version) | Patch version number of the Redis engine used by the cluster |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | Cluster name |
| <a name="output_cluster_shards"></a> [cluster\_shards](#output\_cluster\_shards) | Set of shards in this cluster |
| <a name="output_multi_region_cluster_arn"></a> [multi\_region\_cluster\_arn](#output\_multi\_region\_cluster\_arn) | The ARN of the multi-region cluster |
| <a name="output_multi_region_cluster_name"></a> [multi\_region\_cluster\_name](#output\_multi\_region\_cluster\_name) | The name of the multi-region cluster |
| <a name="output_parameter_group_arn"></a> [parameter\_group\_arn](#output\_parameter\_group\_arn) | The ARN of the parameter group |
| <a name="output_parameter_group_id"></a> [parameter\_group\_id](#output\_parameter\_group\_id) | Name of the parameter group |
| <a name="output_subnet_group_arn"></a> [subnet\_group\_arn](#output\_subnet\_group\_arn) | ARN of the subnet group |
| <a name="output_subnet_group_id"></a> [subnet\_group\_id](#output\_subnet\_group\_id) | Name of the subnet group |
| <a name="output_subnet_group_vpc_id"></a> [subnet\_group\_vpc\_id](#output\_subnet\_group\_vpc\_id) | The VPC in which the subnet group exists |
| <a name="output_users"></a> [users](#output\_users) | Map of attributes for the users created |
<!-- END_TF_DOCS -->
