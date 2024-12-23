resource "aws_memorydb_multi_region_cluster" "this" {
  count = var.create ? 1 : 0

  multi_region_cluster_name_suffix = var.multi_region_cluster_name_suffix
  node_type                        = var.node_type

  description                       = var.description
  engine                            = var.engine
  engine_version                    = var.engine_version
  multi_region_parameter_group_name = var.multi_region_parameter_group_name
  num_shards                        = var.num_shards
  tls_enabled                       = var.tls_enabled

  tags = var.tags

  timeouts {
    create = try(var.timeouts.create, "120m")
    update = try(var.timeouts.update, "120m")
    delete = try(var.timeouts.delete, "120m")
  }
}
