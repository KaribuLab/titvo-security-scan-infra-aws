terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-dynamodb-table.git?ref=v4.1.0"
}

locals {
  common             = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  environment        = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  common_tags        = local.common.locals.tags
  name               = "${local.common.locals.project_name}-task-${local.environment.locals.name}"
  hash_key           = "scan_id"
  ttl_attribute_name = "ttl"
  ttl_enabled        = false

  attributes = [
    {
      name = "scan_id"
      type = "S"
    },
    {
      name = "repository_id"
      type = "S"
    },
    {
      name = "created_at"
      type = "S"
    }
  ]

  global_secondary_indexes = [
    {
      name               = "repository_id_index"
      hash_key           = "repository_id"
      range_key          = "created_at"
      projection_type    = "INCLUDE"
      non_key_attributes = ["status", "source", "branch", "updated_at", "job_id"]
    }
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
