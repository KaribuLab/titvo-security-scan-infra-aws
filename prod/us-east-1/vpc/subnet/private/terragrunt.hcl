terraform {
  source = "${get_parent_terragrunt_dir()}/module/subnet"
}

locals {
  common      = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  environment = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  region      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  base_path   = "${local.common.locals.parameter_path}/${local.environment.locals.name}/infra"
  subnet_name = "Private Subnets Titvo Production"
  common_tags = merge(local.common.locals.tags, {
    Name = local.subnet_name
  })
  fallback_subnets = [
    {
      cidr_block        = "172.31.64.0/20"
      availability_zone = "us-east-1a"
    },
    {
      cidr_block        = "172.31.80.0/20"
      availability_zone = "us-east-1b"
    },
    {
      cidr_block        = "172.31.96.0/20"
      availability_zone = "us-east-1c"
    }
  ]
}

dependency "parameter" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/ssm/paremeter/lookup"
  mock_outputs = {
    parameters = {
      "${local.base_path}/vpc/vpc_id" = "vpc-000000000000000"
      "${local.base_path}/vpc/subnets/private" = jsonencode([
        {
          cidr_block        = "172.31.64.0/20"
          availability_zone = "us-east-1a"
        },
        {
          cidr_block        = "172.31.80.0/20"
          availability_zone = "us-east-1b"
        },
        {
          cidr_block        = "172.31.96.0/20"
          availability_zone = "us-east-1c"
        }
      ])
    }
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate"]
}

include {
  path = find_in_parent_folders()
}

inputs = {
  vpc_id      = try(dependency.parameter.outputs.parameters["${local.base_path}/vpc/vpc_id"], dependency.parameter.outputs.parameters["${local.base_path}/vpc-id"], "vpc-000000000000000")
  description = local.subnet_name
  subnets     = try(jsondecode(dependency.parameter.outputs.parameters["${local.base_path}/vpc/subnets/private"]), local.fallback_subnets)
  tags        = local.common_tags
}
