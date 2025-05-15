terraform {
  source = "git::https://github.com/KaribuLab/terraform-aws-network.git?ref=v0.0.1"
}

locals {
  region      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  common      = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  environment = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  common_tags = local.common.locals.tags
}

include {
  path = find_in_parent_folders()
}
inputs = {
  customer    = local.common.locals.project_name
  environment = local.environment.locals.name
  vpc_cidr    = "10.0.0.0/16"
  subnet_public = {
    cidr = "0.0.0.0/0"
    subnets = [{
      az   = "${local.region.locals.name}a"
      cidr = "10.0.0.0/24"
      },
      {
        az   = "${local.region.locals.name}b"
        cidr = "10.0.1.0/24"
      }
    ]
  }
  subnet_private = {
    cidr = "0.0.0.0/0"
    subnets = [{
      az   = "${local.region.locals.name}a"
      cidr = "10.0.6.0/24"
      },
      {
        az   = "${local.region.locals.name}b"
        cidr = "10.0.7.0/24"
      }
    ]
  }
  tags = local.common_tags
}
