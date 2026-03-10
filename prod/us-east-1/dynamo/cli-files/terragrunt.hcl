terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-dynamodb-table.git?ref=v4.1.0"
}

locals {
  common             = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  environment        = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  common_tags        = local.common.locals.tags
  name               = "${local.common.locals.project_name}-cli-files-${local.environment.locals.name}"
  hash_key           = "file_id"
  ttl_attribute_name = "ttl"
  ttl_enabled        = true

  attributes = [
    {
      name = "file_id"
      type = "S"
    },
    {
      name = "batch_id"
      type = "S"
    }
  ]

  global_secondary_indexes = [
    {
      name            = "batch_id_gsi"
      hash_key        = "batch_id"
      projection_type = "ALL"
    },
  ]
}

include {
  path = find_in_parent_folders()
}

inputs = {
  hash_key                 = local.hash_key
  ttl_attribute_name       = local.ttl_attribute_name
  ttl_enabled              = local.ttl_enabled
  attributes               = local.attributes
  global_secondary_indexes = local.global_secondary_indexes
  name                     = local.name
  tags                     = local.common_tags
}
