provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {
  # Exclude local zones
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

locals {
  region = "eu-west-1"
  name   = "ex-${basename(path.cwd)}"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Name       = local.name
    Example    = local.name
    Repository = "https://github.com/terraform-aws-modules/terraform-aws-memory-db"
  }
}

################################################################################
# MemoryDB Module
################################################################################

module "memory_db" {
  source = "../.."

  # Cluster
  name        = local.name
  description = "Example MemoryDB cluster"

  engine                     = "valkey"
  engine_version             = "7.3"
  auto_minor_version_upgrade = true
  node_type                  = "db.r6gd.xlarge"
  num_shards                 = 2
  num_replicas_per_shard     = 2
  data_tiering               = true

  tls_enabled              = true
  security_group_ids       = [module.security_group.security_group_id]
  maintenance_window       = "sun:23:00-mon:01:30"
  sns_topic_arn            = aws_sns_topic.example.arn
  snapshot_retention_limit = 7
  snapshot_window          = "05:00-09:00"

  # Users
  users = {
    admin = {
      user_name     = "valkey-admin-user"
      access_string = "on ~* &* +@all"
      type          = "iam"
      tags          = { user = "admin" }
    }
    readonly = {
      user_name     = "valkey-readonly-user"
      access_string = "on ~* &* -@all +@read"
      passwords     = [random_password.password.result]
      tags          = { user = "readonly" }
    }
  }

  # ACL
  acl_name = "${local.name}-acl"
  acl_tags = { acl = "custom" }

  # Parameter group
  parameter_group_name        = "${local.name}-param-group"
  parameter_group_description = "Example Valkey MemoryDB parameter group"
  parameter_group_family      = "memorydb_valkey7"
  parameter_group_parameters = [
    {
      name  = "activedefrag"
      value = "yes"
    }
  ]
  parameter_group_tags = {
    parameter_group = "custom"
  }

  # Subnet group
  subnet_group_name        = "${local.name}-subnet-group"
  subnet_group_description = "Example Valkey MemoryDB subnet group"
  subnet_ids               = module.vpc.database_subnets
  subnet_group_tags = {
    subnet_group = "custom"
  }

  tags = local.tags
}

module "memory_db_disabled" {
  source = "../.."

  name   = "${local.name}-disabled"
  create = false
}

################################################################################
# Supporting Resources
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name = local.name
  cidr = local.vpc_cidr

  azs              = local.azs
  private_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]
  database_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 48)]

  create_database_subnet_group = true
  enable_nat_gateway           = false

  manage_default_security_group  = true
  default_security_group_ingress = []
  default_security_group_egress  = []

  tags = local.tags
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = local.name
  description = "Security group for ${local.name}"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = module.vpc.private_subnets_cidr_blocks
  ingress_rules       = ["redis-tcp"]

  egress_cidr_blocks = [module.vpc.vpc_cidr_block]
  egress_rules       = ["all-all"]

  tags = local.tags
}

resource "aws_sns_topic" "example" {
  name              = local.name
  kms_master_key_id = "alias/aws/sns"

  tags = local.tags
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}
