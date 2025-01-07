variable "create" {
  description = "Determines whether resources will be created - affects all resources"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to use on all resources"
  type        = map(string)
  default     = {}
}

################################################################################
# Cluster
################################################################################

variable "name" {
  description = "Cluster name - also default name used on all resources if more specific resource names are not provided"
  type        = string
  default     = ""
}

variable "use_name_prefix" {
  description = "Determines whether `name` is used as a prefix for the cluster"
  type        = bool
  default     = false
}

variable "description" {
  description = "Description for the cluster. Defaults to `Managed by Terraform`"
  type        = string
  default     = null
}

variable "engine" {
  description = "The engine that will run on your nodes. Supported values are redis and valkey"
  type        = string
  default     = null
}

variable "engine_version" {
  description = "Version number of the engine to be used for the cluster. Downgrades are not supported"
  type        = string
  default     = null
}

variable "auto_minor_version_upgrade" {
  description = "When set to `true`, the cluster will automatically receive minor engine version upgrades after launch. Defaults to `true`"
  type        = bool
  default     = null
}

variable "port" {
  description = "The port number on which each of the nodes accepts connections. Defaults to `6379`"
  type        = number
  default     = null
}

variable "node_type" {
  description = "The compute and memory capacity of the nodes in the cluster. See AWS documentation on [supported node types](https://docs.aws.amazon.com/memorydb/latest/devguide/nodes.supportedtypes.html) as well as [vertical scaling](https://docs.aws.amazon.com/memorydb/latest/devguide/cluster-vertical-scaling.html)"
  type        = string
  default     = null
}

variable "num_shards" {
  description = "The number of shards in the cluster. Defaults to `1`"
  type        = number
  default     = null
}

variable "num_replicas_per_shard" {
  description = "The number of replicas to apply to each shard, up to a maximum of 5. Defaults to `1` (i.e. 2 nodes per shard)"
  type        = number
  default     = null
}

variable "kms_key_arn" {
  description = "ARN of the KMS key used to encrypt the cluster at rest"
  type        = string
  default     = null
}

variable "tls_enabled" {
  description = "A flag to enable in-transit encryption on the cluster. When set to `false`, the `acl_name` must be `open-access`. Defaults to `true`"
  type        = bool
  default     = null
}

variable "security_group_ids" {
  description = "Set of VPC Security Group ID-s to associate with this cluster"
  type        = list(string)
  default     = null
}

variable "maintenance_window" {
  description = "Specifies the weekly time range during which maintenance on the cluster is performed. It is specified as a range in the format `ddd:hh24:mi-ddd:hh24:mi`"
  type        = string
  default     = null
}

variable "sns_topic_arn" {
  description = "ARN of the SNS topic to which cluster notifications are sent"
  type        = string
  default     = null
}

variable "snapshot_name" {
  description = "The name of a snapshot from which to restore data into the new cluster"
  type        = string
  default     = null
}

variable "snapshot_arns" {
  description = " List of ARN-s that uniquely identify RDB snapshot files stored in S3. The snapshot files will be used to populate the new cluster"
  type        = list(string)
  default     = null
}

variable "snapshot_retention_limit" {
  description = "The number of days for which MemoryDB retains automatic snapshots before deleting them. When set to `0`, automatic backups are disabled. Defaults to `0`"
  type        = number
  default     = null
}

variable "snapshot_window" {
  description = "The daily time range (in UTC) during which MemoryDB begins taking a daily snapshot of your shard. Example: `05:00-09:00`"
  type        = string
  default     = null
}

variable "final_snapshot_name" {
  description = "Name of the final cluster snapshot to be created when this resource is deleted. If omitted, no final snapshot will be made"
  type        = string
  default     = null
}

variable "data_tiering" {
  description = "Must be set to `true` when using a data tiering node type"
  type        = bool
  default     = null
}

variable "multi_region_cluster_name" {
  description = "The multi region cluster identifier if part of a multi region cluster"
  type        = string
  default     = null
}

################################################################################
# User(s)
################################################################################

variable "create_users" {
  description = "Determines whether to create users specified"
  type        = bool
  default     = true
}

variable "users" {
  description = "A map of user definitions (maps) to be created"
  type        = any
  default     = {}
}

################################################################################
# ACL
################################################################################

variable "create_acl" {
  description = "Determines whether to create ACL specified"
  type        = bool
  default     = true
}

variable "acl_name" {
  description = "Name of ACL to be created if `create_acl` is `true`, otherwise its the name of an existing ACL to use if `create_acl` is `false`"
  type        = string
  default     = null
}

variable "acl_use_name_prefix" {
  description = "Determines whether `acl_name` is used as a prefix"
  type        = bool
  default     = false
}

variable "acl_user_names" {
  description = "List of externally created user names to associate with the ACL"
  type        = list(string)
  default     = []
}

variable "acl_tags" {
  description = "Additional tags for the ACL created"
  type        = map(string)
  default     = {}
}

################################################################################
# Parameter Group
################################################################################

variable "create_parameter_group" {
  description = "Determines whether to create parameter group specified"
  type        = bool
  default     = true
}

variable "parameter_group_name" {
  description = "Name of parameter group to be created if `create_parameter_group` is `true`, otherwise its the name of an existing parameter group to use if `create_parameter_group` is `false`"
  type        = string
  default     = null
}

variable "parameter_group_use_name_prefix" {
  description = "Determines whether `parameter_group_name` is used as a prefix"
  type        = bool
  default     = false
}

variable "parameter_group_description" {
  description = "Description for the parameter group. Defaults to `Managed by Terraform`"
  type        = string
  default     = null
}

variable "parameter_group_family" {
  description = "The engine version that the parameter group can be used with"
  type        = string
  default     = null
}

variable "parameter_group_parameters" {
  description = "A list of parameter maps to apply"
  type        = list(map(string))
  default     = []
}

variable "parameter_group_tags" {
  description = "Additional tags for the parameter group created"
  type        = map(string)
  default     = {}
}

################################################################################
# Subnet Group
################################################################################

variable "create_subnet_group" {
  description = "Determines whether to create subnet group specified"
  type        = bool
  default     = true
}

variable "subnet_group_name" {
  description = "Name of subnet group to be created if `create_subnet_group` is `true`, otherwise its the name of an existing subnet group to use if `create_subnet_group` is `false`"
  type        = string
  default     = null
}

variable "subnet_group_use_name_prefix" {
  description = "Determines whether `subnet_group_name` is used as a prefix"
  type        = bool
  default     = false
}

variable "subnet_group_description" {
  description = "Description for the subnet group. Defaults to `Managed by Terraform`"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "Set of VPC Subnet ID-s for the subnet group. At least one subnet must be provided"
  type        = list(string)
  default     = []
}

variable "subnet_group_tags" {
  description = "Additional tags for the subnet group created"
  type        = map(string)
  default     = {}
}
