################################################################################
# Cluster
################################################################################

output "cluster_id" {
  description = "Cluster name"
  value       = module.memory_db.cluster_id
}

output "cluster_arn" {
  description = "The ARN of the cluster"
  value       = module.memory_db.cluster_arn
}

output "cluster_endpoint_address" {
  description = "DNS hostname of the cluster configuration endpoint"
  value       = module.memory_db.cluster_endpoint_address
}

output "cluster_endpoint_port" {
  description = "Port number that the cluster configuration endpoint is listening on"
  value       = module.memory_db.cluster_endpoint_port
}

output "cluster_engine_patch_version" {
  description = "Patch version number of the Redis engine used by the cluster"
  value       = module.memory_db.cluster_engine_patch_version
}

output "cluster_shards" {
  description = "Set of shards in this cluster"
  value       = module.memory_db.cluster_shards
}

################################################################################
# User(s)
################################################################################

output "users" {
  description = "Map of attributes for the users created"
  value       = module.memory_db.users
  sensitive   = true
}

################################################################################
# ACL
################################################################################

output "acl_id" {
  description = "Name of the ACL"
  value       = module.memory_db.acl_id
}

output "acl_arn" {
  description = "The ARN of the ACL"
  value       = module.memory_db.acl_arn
}

output "acl_minimum_engine_version" {
  description = "The minimum engine version supported by the ACL"
  value       = module.memory_db.acl_minimum_engine_version
}

################################################################################
# Parameter Group
################################################################################

output "parameter_group_id" {
  description = "Name of the parameter group"
  value       = module.memory_db.parameter_group_id
}

output "parameter_group_arn" {
  description = "The ARN of the parameter group"
  value       = module.memory_db.parameter_group_arn
}

################################################################################
# Subnet Group
################################################################################

output "subnet_group_id" {
  description = "Name of the subnet group"
  value       = module.memory_db.subnet_group_id
}

output "subnet_group_arn" {
  description = "ARN of the subnet group"
  value       = module.memory_db.subnet_group_arn
}

output "subnet_group_vpc_id" {
  description = "The VPC in which the subnet group exists"
  value       = module.memory_db.subnet_group_vpc_id
}
