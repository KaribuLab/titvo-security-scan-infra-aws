terraform {
  source = "git::https://github.com/KaribuLab/terraform-aws-api-gateway.git?ref=v1.0.0"
}

locals {
  common                     = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  context                    = read_terragrunt_config(find_in_parent_folders("context.hcl"))
  environment                = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  region                     = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  common_tags                = local.common.locals.tags
  api_gateway_name           = "${local.common.locals.project_name}-${local.context.locals.name}-apigateway-${local.environment.locals.name}"
  task_trigger_lambda_name   = get_env("TASK_TRIGGER_LAMBDA_NAME", "tvo-task-trigger-lambda")
  task_status_lambda_name    = get_env("TASK_STATUS_LAMBDA_NAME", "tvo-task-status-lambda")
  task_cli_files_lambda_name = get_env("TASK_CLI_FILES_LAMBDA_NAME", "tvo-task-cli-files-lambda")
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name        = local.api_gateway_name
  stage_name  = "v1"
  common_tags = local.common_tags
}
