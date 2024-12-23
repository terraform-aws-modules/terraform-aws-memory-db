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

variable "multi_region_cluster_name_suffix" {
  description = "A suffix to be added to the multi-region cluster name. An AWS generated prefix is automatically applied to the multi-region cluster name when it is created"
  type        = string
  default     = null
}

variable "multi_region_parameter_group_name" {
  description = "The name of the multi-region parameter group to be associated with the cluster"
  type        = string
  default     = null
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

variable "tls_enabled" {
  description = "A flag to enable in-transit encryption on the cluster. When set to `false`, the `acl_name` must be `open-access`. Defaults to `true`"
  type        = bool
  default     = null
}

variable "timeouts" {
  description = "Define maximum timeout for creating, updating, and deleting memorydb resources"
  type        = map(string)
  default     = {}
}
