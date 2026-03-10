terraform {
  source = "${get_parent_terragrunt_dir()}/module/security-group"
}

locals {
  common              = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  environment         = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  region              = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  base_path           = "${local.common.locals.parameter_path}/${local.environment.locals.name}/infra"
  security_group_name = "Security Group Lambda Titvo Production"
  common_tags = merge(local.common.locals.tags, {
    Name = local.security_group_name
  })
}

dependency "parameter" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/ssm/paremeter/lookup"
  mock_outputs = {
    parameters = {
      "${local.base_path}/vpc/vpc_id" = "vpc-000000000000000"
    }
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name        = local.security_group_name
  vpc_id      = try(dependency.parameter.outputs.parameters["${local.base_path}/vpc/vpc_id"], dependency.parameter.outputs.parameters["${local.base_path}/vpc-id"], "vpc-000000000000000")
  common_tags = local.common_tags
  description = "Security Group Lambda Titvo ${lookup(local.common.locals.environments, local.environment.locals.name, "Unknown")}"
}
