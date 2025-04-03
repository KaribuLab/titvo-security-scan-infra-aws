terraform {
  source = "git::https://github.com/KaribuLab/terraform-aws-api-gateway.git?ref=v0.4.4"
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
    {
      path          = "/run-scan"
      method        = "POST"
      function_name = "tvo-task-trigger-lambda-${local.environment.locals.name}"
    },
    {
      path          = "/scan-status"
      method        = "POST"
      function_name = "tvo-task-status-lambda-${local.environment.locals.name}"
    },
    {
      path          = "/cli-files"
      method        = "POST"
      function_name = "tvo-task-cli-files-lambda-${local.environment.locals.name}"
    }
  ]
  common_tags = local.common_tags
}
