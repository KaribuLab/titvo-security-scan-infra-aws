terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-dynamodb-table.git?ref=v4.1.0"
}

locals {
  common      = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  environment = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  common_tags = local.common.locals.tags
  name        = "${local.common.locals.project_name}-user-${local.environment.locals.name}"
  hash_key    = "user_id"

  attributes = [
    {
      name = "user_id"
      type = "S"
    },
    {
      name = "email"
      type = "S"
    }
  ]

  global_secondary_indexes = [
    {
      name            = "EmailIndex"
      hash_key        = "email"
      projection_type = "ALL"
      billing_mode    = "PAY_PER_REQUEST"
    }
  ]
}

include {
  path = find_in_parent_folders()
}
inputs = {
  hash_key                 = local.hash_key
  attributes               = local.attributes
  global_secondary_indexes = local.global_secondary_indexes
  name                     = local.name
  tags                     = local.common_tags
}
