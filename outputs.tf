################################################################################
# Cluster
################################################################################

output "cluster_id" {
  description = "Cluster name"
  value       = try(aws_memorydb_cluster.this[0].id, null)
}

output "cluster_arn" {
  description = "The ARN of the cluster"
  value       = try(aws_memorydb_cluster.this[0].arn, null)
}

output "cluster_endpoint_address" {
  description = "DNS hostname of the cluster configuration endpoint"
  value       = try(aws_memorydb_cluster.this[0].cluster_endpoint[0].address, null)
}

output "cluster_endpoint_port" {
  description = "Port number that the cluster configuration endpoint is listening on"
  value       = try(aws_memorydb_cluster.this[0].cluster_endpoint[0].port, null)
}

output "cluster_engine_patch_version" {
  description = "Patch version number of the Redis engine used by the cluster"
  value       = try(aws_memorydb_cluster.this[0].engine_patch_version, null)
}

output "cluster_shards" {
  description = "Set of shards in this cluster"
  value       = try(aws_memorydb_cluster.this[0].shards, null)
}

################################################################################
# User(s)
################################################################################

output "users" {
  description = "Map of attributes for the users created"
  value       = aws_memorydb_user.this
  sensitive   = true
}

################################################################################
# ACL
################################################################################

output "acl_id" {
  description = "Name of the ACL"
  value       = try(aws_memorydb_acl.this[0].id, null)
}

output "acl_arn" {
  description = "The ARN of the ACL"
  value       = try(aws_memorydb_acl.this[0].arn, null)
}

output "acl_minimum_engine_version" {
  description = "The minimum engine version supported by the ACL"
  value       = try(aws_memorydb_acl.this[0].minimum_engine_version, null)
}

################################################################################
# Parameter Group
################################################################################

output "parameter_group_id" {
  description = "Name of the parameter group"
  value       = try(aws_memorydb_parameter_group.this[0].id, null)
}

output "parameter_group_arn" {
  description = "The ARN of the parameter group"
  value       = try(aws_memorydb_parameter_group.this[0].arn, null)
}

################################################################################
# Subnet Group
################################################################################

output "subnet_group_id" {
  description = "Name of the subnet group"
  value       = try(aws_memorydb_subnet_group.this[0].id, null)
}

output "subnet_group_arn" {
  description = "ARN of the subnet group"
  value       = try(aws_memorydb_subnet_group.this[0].arn, null)
}

output "subnet_group_vpc_id" {
  description = "The VPC in which the subnet group exists"
  value       = try(aws_memorydb_subnet_group.this[0].vpc_id, null)
}
