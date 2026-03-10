terraform {
  source = "git::https://github.com/KaribuLab/terraform-aws-sqs.git?ref=v0.2.0"
}

locals {
  common          = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  environment     = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  customer_prefix = local.common.locals.project_prefix
  queue_name      = "${local.customer_prefix}-issue-report-output-${local.environment.locals.name}"
  common_tags = merge(local.common.locals.tags, {
    Name = local.queue_name
  })
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name                  = local.queue_name
  max_delivery_attempts = 3
  common_tags           = local.common_tags
}
