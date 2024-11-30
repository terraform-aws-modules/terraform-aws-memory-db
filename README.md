# AWS MemoryDB Terraform module

Terraform module which creates AWS MemoryDB resources.

## Usage

See [`examples`](https://github.com/terraform-aws-modules/terraform-aws-memory-db/tree/master/examples) directory for working examples to reference:

```hcl
module "memory_db" {
  source = "terraform-aws-modules/memory-db/aws"

  # Cluster
  name        = "example"
  description = "Example MemoryDB cluster"

  engine_version             = "6.2"
  auto_minor_version_upgrade = true
  node_type                  = "db.t4g.small"
  num_shards                 = 2
  num_replicas_per_shard     = 2

  tls_enabled              = true
  security_group_ids       = ["sg-12345678"]
  maintenance_window       = "sun:23:00-mon:01:30"
  sns_topic_arn            = "arn:aws:sns:us-east-1:012345678910:example-topic"
  snapshot_retention_limit = 7
  snapshot_window          = "05:00-09:00"

  # Users
  users = {
    admin = {
      user_name     = "admin-user"
      access_string = "on ~* &* +@all"
      passwords     = ["YouShouldPickAStrongSecurePassword987!"]
      tags          = { User = "admin" }
    }
    readonly = {
      user_name     = "readonly-user"
      access_string = "on ~* &* -@all +@read"
      passwords     = ["YouShouldPickAStrongSecurePassword123!"]
      tags          = { User = "readonly" }
    }
  }

  # ACL
  acl_name = "example-acl"
  acl_tags = { Acl = "custom" }

  # Parameter group
  parameter_group_name        = "example-param-group"
  parameter_group_description = "Example MemoryDB parameter group"
  parameter_group_family      = "memorydb_redis6"
  parameter_group_parameters = [
    {
      name  = "activedefrag"
      value = "yes"
    }
  ]
  parameter_group_tags = {
    ParameterGroup = "custom"
  }

  # Subnet group
  subnet_group_name        = "example-subnet-group"
  subnet_group_description = "Example MemoryDB subnet group"
  subnet_ids               = ["subnet-1fe3d837", "subnet-129d66ab", "subnet-1211eef5"]
  subnet_group_tags = {
    SubnetGroup = "custom"
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

## Conditional Creation

The following values are provided to toggle on/off creation of the associated resources as desired:

```hcl
module "memory_db" {
  source = "terraform-aws-modules/memory-db/aws"

  # Disable creation of cluster and all resources
  create = false

  # Disable creation of users
  create_users = false

  # Disable creation of ACL - an ACL will need to be provided
  create_acl = false
  acl_name   = "existing_acl"

  # Disable creation of parameter group - a parameter group will need to be provided
  create_parameter_group = false
  parameter_group_name   = "existing_parameter_group"

  # Disable creation of subnet group - a subnet group will need to be provided
  create_subnet_group = false
  subnet_group_name   = "existing_subnet_group"

  # ... omitted
}
```

## Examples

Examples codified under the [`examples`](https://github.com/terraform-aws-modules/terraform-aws-memory-db/tree/master/examples) are intended to give users references for how to use the module(s) as well as testing/validating changes to the source code of the module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow maintainers to test your changes and to keep the examples up to date for users. Thank you!

- [Complete](https://github.com/terraform-aws-modules/terraform-aws-memory-db/tree/master/examples/complete)
- [Valkey](https://github.com/terraform-aws-modules/terraform-aws-memory-db/tree/master/examples/valkey)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.78 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.78 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_memorydb_acl.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/memorydb_acl) | resource |
| [aws_memorydb_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/memorydb_cluster) | resource |
| [aws_memorydb_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/memorydb_parameter_group) | resource |
| [aws_memorydb_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/memorydb_subnet_group) | resource |
| [aws_memorydb_user.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/memorydb_user) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acl_name"></a> [acl\_name](#input\_acl\_name) | Name of ACL to be created if `create_acl` is `true`, otherwise its the name of an existing ACL to use if `create_acl` is `false` | `string` | `null` | no |
| <a name="input_acl_tags"></a> [acl\_tags](#input\_acl\_tags) | Additional tags for the ACL created | `map(string)` | `{}` | no |
| <a name="input_acl_use_name_prefix"></a> [acl\_use\_name\_prefix](#input\_acl\_use\_name\_prefix) | Determines whether `acl_name` is used as a prefix | `bool` | `false` | no |
| <a name="input_acl_user_names"></a> [acl\_user\_names](#input\_acl\_user\_names) | List of externally created user names to associate with the ACL | `list(string)` | `[]` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | When set to `true`, the cluster will automatically receive minor engine version upgrades after launch. Defaults to `true` | `bool` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Determines whether resources will be created - affects all resources | `bool` | `true` | no |
| <a name="input_create_acl"></a> [create\_acl](#input\_create\_acl) | Determines whether to create ACL specified | `bool` | `true` | no |
| <a name="input_create_parameter_group"></a> [create\_parameter\_group](#input\_create\_parameter\_group) | Determines whether to create parameter group specified | `bool` | `true` | no |
| <a name="input_create_subnet_group"></a> [create\_subnet\_group](#input\_create\_subnet\_group) | Determines whether to create subnet group specified | `bool` | `true` | no |
| <a name="input_create_users"></a> [create\_users](#input\_create\_users) | Determines whether to create users specified | `bool` | `true` | no |
| <a name="input_data_tiering"></a> [data\_tiering](#input\_data\_tiering) | Must be set to `true` when using a data tiering node type | `bool` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | Description for the cluster. Defaults to `Managed by Terraform` | `string` | `null` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | The engine that will run on your nodes. Supported values are redis and valkey | `string` | `null` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Version number of the engine to be used for the cluster. Downgrades are not supported | `string` | `null` | no |
| <a name="input_final_snapshot_name"></a> [final\_snapshot\_name](#input\_final\_snapshot\_name) | Name of the final cluster snapshot to be created when this resource is deleted. If omitted, no final snapshot will be made | `string` | `null` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | ARN of the KMS key used to encrypt the cluster at rest | `string` | `null` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | Specifies the weekly time range during which maintenance on the cluster is performed. It is specified as a range in the format `ddd:hh24:mi-ddd:hh24:mi` | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Cluster name - also default name used on all resources if more specific resource names are not provided | `string` | `""` | no |
| <a name="input_node_type"></a> [node\_type](#input\_node\_type) | The compute and memory capacity of the nodes in the cluster. See AWS documentation on [supported node types](https://docs.aws.amazon.com/memorydb/latest/devguide/nodes.supportedtypes.html) as well as [vertical scaling](https://docs.aws.amazon.com/memorydb/latest/devguide/cluster-vertical-scaling.html) | `string` | `null` | no |
| <a name="input_num_replicas_per_shard"></a> [num\_replicas\_per\_shard](#input\_num\_replicas\_per\_shard) | The number of replicas to apply to each shard, up to a maximum of 5. Defaults to `1` (i.e. 2 nodes per shard) | `number` | `null` | no |
| <a name="input_num_shards"></a> [num\_shards](#input\_num\_shards) | The number of shards in the cluster. Defaults to `1` | `number` | `null` | no |
| <a name="input_parameter_group_description"></a> [parameter\_group\_description](#input\_parameter\_group\_description) | Description for the parameter group. Defaults to `Managed by Terraform` | `string` | `null` | no |
| <a name="input_parameter_group_family"></a> [parameter\_group\_family](#input\_parameter\_group\_family) | The engine version that the parameter group can be used with | `string` | `null` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | Name of parameter group to be created if `create_parameter_group` is `true`, otherwise its the name of an existing parameter group to use if `create_parameter_group` is `false` | `string` | `null` | no |
| <a name="input_parameter_group_parameters"></a> [parameter\_group\_parameters](#input\_parameter\_group\_parameters) | A list of parameter maps to apply | `list(map(string))` | `[]` | no |
| <a name="input_parameter_group_tags"></a> [parameter\_group\_tags](#input\_parameter\_group\_tags) | Additional tags for the parameter group created | `map(string)` | `{}` | no |
| <a name="input_parameter_group_use_name_prefix"></a> [parameter\_group\_use\_name\_prefix](#input\_parameter\_group\_use\_name\_prefix) | Determines whether `parameter_group_name` is used as a prefix | `bool` | `false` | no |
| <a name="input_port"></a> [port](#input\_port) | The port number on which each of the nodes accepts connections. Defaults to `6379` | `number` | `null` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Set of VPC Security Group ID-s to associate with this cluster | `list(string)` | `null` | no |
| <a name="input_snapshot_arns"></a> [snapshot\_arns](#input\_snapshot\_arns) | List of ARN-s that uniquely identify RDB snapshot files stored in S3. The snapshot files will be used to populate the new cluster | `list(string)` | `null` | no |
| <a name="input_snapshot_name"></a> [snapshot\_name](#input\_snapshot\_name) | The name of a snapshot from which to restore data into the new cluster | `string` | `null` | no |
| <a name="input_snapshot_retention_limit"></a> [snapshot\_retention\_limit](#input\_snapshot\_retention\_limit) | The number of days for which MemoryDB retains automatic snapshots before deleting them. When set to `0`, automatic backups are disabled. Defaults to `0` | `number` | `null` | no |
| <a name="input_snapshot_window"></a> [snapshot\_window](#input\_snapshot\_window) | The daily time range (in UTC) during which MemoryDB begins taking a daily snapshot of your shard. Example: `05:00-09:00` | `string` | `null` | no |
| <a name="input_sns_topic_arn"></a> [sns\_topic\_arn](#input\_sns\_topic\_arn) | ARN of the SNS topic to which cluster notifications are sent | `string` | `null` | no |
| <a name="input_subnet_group_description"></a> [subnet\_group\_description](#input\_subnet\_group\_description) | Description for the subnet group. Defaults to `Managed by Terraform` | `string` | `null` | no |
| <a name="input_subnet_group_name"></a> [subnet\_group\_name](#input\_subnet\_group\_name) | Name of subnet group to be created if `create_subnet_group` is `true`, otherwise its the name of an existing subnet group to use if `create_subnet_group` is `false` | `string` | `null` | no |
| <a name="input_subnet_group_tags"></a> [subnet\_group\_tags](#input\_subnet\_group\_tags) | Additional tags for the subnet group created | `map(string)` | `{}` | no |
| <a name="input_subnet_group_use_name_prefix"></a> [subnet\_group\_use\_name\_prefix](#input\_subnet\_group\_use\_name\_prefix) | Determines whether `subnet_group_name` is used as a prefix | `bool` | `false` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Set of VPC Subnet ID-s for the subnet group. At least one subnet must be provided | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to use on all resources | `map(string)` | `{}` | no |
| <a name="input_tls_enabled"></a> [tls\_enabled](#input\_tls\_enabled) | A flag to enable in-transit encryption on the cluster. When set to `false`, the `acl_name` must be `open-access`. Defaults to `true` | `bool` | `null` | no |
| <a name="input_use_name_prefix"></a> [use\_name\_prefix](#input\_use\_name\_prefix) | Determines whether `name` is used as a prefix for the cluster | `bool` | `false` | no |
| <a name="input_users"></a> [users](#input\_users) | A map of user definitions (maps) to be created | `any` | `{}` | no |

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
| <a name="output_parameter_group_arn"></a> [parameter\_group\_arn](#output\_parameter\_group\_arn) | The ARN of the parameter group |
| <a name="output_parameter_group_id"></a> [parameter\_group\_id](#output\_parameter\_group\_id) | Name of the parameter group |
| <a name="output_subnet_group_arn"></a> [subnet\_group\_arn](#output\_subnet\_group\_arn) | ARN of the subnet group |
| <a name="output_subnet_group_id"></a> [subnet\_group\_id](#output\_subnet\_group\_id) | Name of the subnet group |
| <a name="output_subnet_group_vpc_id"></a> [subnet\_group\_vpc\_id](#output\_subnet\_group\_vpc\_id) | The VPC in which the subnet group exists |
| <a name="output_users"></a> [users](#output\_users) | Map of attributes for the users created |
<!-- END_TF_DOCS -->

## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-memory-db/blob/master/LICENSE).
