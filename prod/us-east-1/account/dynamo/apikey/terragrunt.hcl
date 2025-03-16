terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-dynamodb-table.git?ref=v4.1.0"
}

locals {
  apikey      = read_terragrunt_config("${get_parent_terragrunt_dir()}/common/dynamodb/account/apikey.hcl")
  context     = read_terragrunt_config(find_in_parent_folders("context.hcl"))
  common      = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  environment = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  common_tags = local.common.locals.tags
  name        = "${local.common.locals.project_name}-${local.context.locals.name}-apikey-${local.environment.locals.name}"
}

include {
  path = find_in_parent_folders()
}
inputs = merge(
  local.apikey.locals,
  {
    name = local.name,
    tags = local.common_tags
  }
)
