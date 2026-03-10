terraform {
  source = "git::https://github.com/KaribuLab/terraform-aws-ecs-cluster.git?ref=v0.2.0"
}

locals {
  common          = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  environment     = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  customer_prefix = local.common.locals.project_prefix
  cluster_name    = "${local.customer_prefix}-cluster-${local.environment.locals.name}"
  common_tags = merge(local.common.locals.tags, {
    Name = local.cluster_name
  })
}

include {
  path = find_in_parent_folders()
}

inputs = {
  cluster_name = local.cluster_name
  tags         = local.common_tags
}
