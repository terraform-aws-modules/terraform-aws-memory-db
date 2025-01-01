provider "aws" {
  region = local.region
}

locals {
  region = "us-east-1"
  name   = "memorydb-ex-${replace(basename(path.cwd), "_", "-")}"

  tags = {
    Example     = local.name
    Environment = "dev"
  }
}

################################################################################
# Multi Region MemoryDB Module
################################################################################

module "memory_db_disabled" {
  source = "../.."

  name   = "${local.name}-disabled"
  create = false
}

module "multi_region_cluster" {
  source = "../../modules/multi-region-cluster"

  create                           = true
  multi_region_cluster_name_suffix = local.name
  tls_enabled                      = true
  engine                           = "valkey"
  engine_version                   = "7.3"
  node_type                        = "db.r7g.xlarge"
  num_shards                       = 2
}

module "memory_db" {
  source = "../.."

  # Cluster
  name        = local.name
  description = "Example MemoryDB cluster"

  # This makes it part of the multi region cluster
  multi_region_cluster_name = module.multi_region_cluster.multi_region_cluster_name

  auto_minor_version_upgrade = true
  node_type                  = "db.r7g.xlarge"
  num_shards                 = 2
  num_replicas_per_shard     = 2

  security_group_ids       = [module.security_group.security_group_id]
  maintenance_window       = "sun:23:00-mon:01:30"
  snapshot_retention_limit = 7
  snapshot_window          = "05:00-09:00"

  # Users
  users = {
    admin = {
      user_name     = "admin-user"
      access_string = "on ~* &* +@all"
      type          = "iam"
      tags          = { user = "admin" }
    }
    readonly = {
      user_name     = "readonly-user"
      access_string = "on ~* &* -@all +@read"
      passwords     = [random_password.password.result]
      tags          = { user = "readonly" }
    }
  }

  # ACL
  create_acl = true
  acl_name   = "${local.name}-acl"
  acl_tags   = { acl = "custom" }

  # Parameter group
  create_parameter_group = false

  # Subnet group
  subnet_group_name        = "${local.name}-subnet-group"
  subnet_group_description = "Example MemoryDB subnet group"
  subnet_ids               = module.vpc.database_subnets
  subnet_group_tags = {
    subnet_group = "custom"
  }

  tags = local.tags
}

# Provides example of an additional region cluster that is part of the multi-region cluster
# Note: Deleting a cluster with existing clusters in other regions can take several hours
# it places the multi-region cluster into an updating state which is not valid for deletion

#provider "aws" {
#  region = "us-west-2"
#  alias  = "us-west-2"
#}

#module "secondary_memory_db" {
#  source = "../.."
#
#  # Cluster
#  name        = "${local.name}-secondary"
#  description = "Example MemoryDB cluster"
#
#  # This makes it part of the multi region cluster
#  multi_region_cluster_name = module.multi_region_cluster.multi_region_cluster_name
#
#  auto_minor_version_upgrade = true
#  node_type                  = "db.r7g.xlarge"
#  num_shards                 = 2
#  num_replicas_per_shard     = 2
#
#  security_group_ids       = [module.secondary_security_group.security_group_id]
#  maintenance_window       = "sun:23:00-mon:01:30"
#  snapshot_retention_limit = 7
#  snapshot_window          = "05:00-09:00"
#
#  # ACL
#  create_acl = true
#  acl_name   = "${local.name}-acl"
#  acl_tags   = { acl = "custom" }
#
#  # Parameter group
#  create_parameter_group = false
#
#  # Subnet group
#  subnet_group_name        = "${local.name}-subnet-group"
#  subnet_group_description = "Example MemoryDB subnet group"
#  subnet_ids               = module.secondary_vpc.database_subnets
#  subnet_group_tags = {
#    subnet_group = "custom"
#  }
#
#  tags = local.tags
#
#  providers = {
#    aws = aws.us-west-2
#  }
#}

################################################################################
# Supporting Resources
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = local.name
  cidr = "10.99.0.0/18"

  azs              = ["${local.region}a", "${local.region}b", "${local.region}d"] # Caution: check which zones are available
  private_subnets  = ["10.99.0.0/24", "10.99.1.0/24", "10.99.2.0/24"]
  database_subnets = ["10.99.3.0/24", "10.99.4.0/24", "10.99.5.0/24"]

  create_database_subnet_group = true
  enable_nat_gateway           = false

  manage_default_security_group  = true
  default_security_group_ingress = []
  default_security_group_egress  = []

  tags = local.tags
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = local.name
  description = "Security group for ${local.name}"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = module.vpc.private_subnets_cidr_blocks
  ingress_rules       = ["redis-tcp"]

  egress_cidr_blocks = [module.vpc.vpc_cidr_block]
  egress_rules       = ["all-all"]

  tags = local.tags
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

#module "secondary_vpc" {
#  source  = "terraform-aws-modules/vpc/aws"
#  version = "~> 5.0"
#
#  name = local.name
#  cidr = "10.99.0.0/18"
#
#  azs              = ["us-west-2a", "us-west-2b", "us-west-2d"] # Caution: check which zones are available
#  private_subnets  = ["10.99.0.0/24", "10.99.1.0/24", "10.99.2.0/24"]
#  database_subnets = ["10.99.3.0/24", "10.99.4.0/24", "10.99.5.0/24"]
#
#  create_database_subnet_group = true
#  enable_nat_gateway           = false
#
#  manage_default_security_group  = true
#  default_security_group_ingress = []
#  default_security_group_egress  = []
#
#  tags = local.tags
#
#  providers = {
#    aws = aws.us-west-2
#  }
#}
#
#module "secondary_security_group" {
#  source  = "terraform-aws-modules/security-group/aws"
#  version = "~> 4.0"
#
#  name        = local.name
#  description = "Security group for ${local.name}"
#  vpc_id      = module.secondary_vpc.vpc_id
#
#  ingress_cidr_blocks = module.secondary_vpc.private_subnets_cidr_blocks
#  ingress_rules       = ["redis-tcp"]
#
#  egress_cidr_blocks = [module.secondary_vpc.vpc_cidr_block]
#  egress_rules       = ["all-all"]
#
#  tags = local.tags
#
#  providers = {
#    aws = aws.us-west-2
#  }
#}
