terraform {
  source = "git::https://github.com/KaribuLab/terraform-aws-api-gateway.git?ref=v0.2.2"
}

locals {
  common           = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  context          = read_terragrunt_config(find_in_parent_folders("context.hcl"))
  environment      = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  region           = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  common_tags      = local.common.locals.tags
  api_gateway_name = "${local.common.locals.project_name}-${local.context.locals.name}-apigateway-${local.environment.locals.name}"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name       = local.api_gateway_name
  stage_name = "v1"
  routes = [
    # {
    #   path          = "/compraBolsa"
    #   method        = "POST"
    #   function_name = "${local.common.locals.project_name}-bundle-purchase-lambda-${local.environment.locals.name}"
    # }
  ]
  common_tags = local.common_tags
}
