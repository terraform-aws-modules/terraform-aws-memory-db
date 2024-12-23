output "multi_region_cluster_arn" {
  description = "The ARN of the multi-region cluster"
  value       = try(aws_memorydb_multi_region_cluster.this[0].arn, null)
}

output "multi_region_cluster_name" {
  description = "The name of the multi-region cluster"
  value       = try(aws_memorydb_multi_region_cluster.this[0].multi_region_cluster_name, null)
}
