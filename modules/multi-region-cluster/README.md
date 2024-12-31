# multi-region cluster

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.82 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.82 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_memorydb_multi_region_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/memorydb_multi_region_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Determines whether resources will be created - affects all resources | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Description for the cluster. Defaults to `Managed by Terraform` | `string` | `null` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | The engine that will run on your nodes. Supported values are redis and valkey | `string` | `null` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Version number of the engine to be used for the cluster. Downgrades are not supported | `string` | `null` | no |
| <a name="input_multi_region_cluster_name_suffix"></a> [multi\_region\_cluster\_name\_suffix](#input\_multi\_region\_cluster\_name\_suffix) | A suffix to be added to the multi-region cluster name. An AWS generated prefix is automatically applied to the multi-region cluster name when it is created | `string` | `null` | no |
| <a name="input_multi_region_parameter_group_name"></a> [multi\_region\_parameter\_group\_name](#input\_multi\_region\_parameter\_group\_name) | The name of the multi-region parameter group to be associated with the cluster | `string` | `null` | no |
| <a name="input_node_type"></a> [node\_type](#input\_node\_type) | The compute and memory capacity of the nodes in the cluster. See AWS documentation on [supported node types](https://docs.aws.amazon.com/memorydb/latest/devguide/nodes.supportedtypes.html) as well as [vertical scaling](https://docs.aws.amazon.com/memorydb/latest/devguide/cluster-vertical-scaling.html) | `string` | `null` | no |
| <a name="input_num_shards"></a> [num\_shards](#input\_num\_shards) | The number of shards in the cluster. Defaults to `1` | `number` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to use on all resources | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Define maximum timeout for creating, updating, and deleting memorydb resources | `map(string)` | `{}` | no |
| <a name="input_tls_enabled"></a> [tls\_enabled](#input\_tls\_enabled) | A flag to enable in-transit encryption on the cluster. When set to `false`, the `acl_name` must be `open-access`. Defaults to `true` | `bool` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_multi_region_cluster_arn"></a> [multi\_region\_cluster\_arn](#output\_multi\_region\_cluster\_arn) | The ARN of the multi-region cluster |
| <a name="output_multi_region_cluster_name"></a> [multi\_region\_cluster\_name](#output\_multi\_region\_cluster\_name) | The name of the multi-region cluster |
<!-- END_TF_DOCS -->
