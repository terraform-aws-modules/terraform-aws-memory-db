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
# MemoryDB Module
################################################################################

module "memory_db_disabled" {
  source = "../.."

  name   = "${local.name}-disabled"
  create = false
}

module "memory_db" {
  source = "../.."

  # Cluster
  name        = local.name
  description = "Example MemoryDB cluster"

  engine                     = "valkey"
  engine_version             = "7.2"
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

################################################################################
# Supporting Resources
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name = local.name
  cidr = "10.98.0.0/18"

  azs              = ["${local.region}a", "${local.region}b", "${local.region}d"] # Caution: check which zones are available
  private_subnets  = ["10.98.0.0/24", "10.98.1.0/24", "10.98.2.0/24"]
  database_subnets = ["10.98.3.0/24", "10.98.4.0/24", "10.98.5.0/24"]

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
