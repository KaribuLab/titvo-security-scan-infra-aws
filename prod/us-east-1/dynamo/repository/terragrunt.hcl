terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-dynamodb-table.git?ref=v4.1.0"
}

locals {
  common      = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  environment = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  common_tags = local.common.locals.tags
  name        = "${local.common.locals.project_name}-repository-${local.environment.locals.name}"
  hash_key    = "repository_id"

  attributes = [
    {
      name = "repository_id"
      type = "S"
    },
    {
      name = "user_id"
      type = "S"
    },
  ]

  global_secondary_indexes = [
    {
      name            = "user_id_gsi"
      hash_key        = "user_id"
      projection_type = "ALL"
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
