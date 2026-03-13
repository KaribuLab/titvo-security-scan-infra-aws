terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-dynamodb-table.git?ref=v4.1.0"
}

locals {
  common             = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  environment        = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  common_tags        = local.common.locals.tags
  name               = "${local.common.locals.project_name}-scan-${local.environment.locals.name}"
  hash_key           = "scan_id"
  ttl_attribute_name = "ttl"
  ttl_enabled        = false

  attributes = [
    {
      name = "scan_id"
      type = "S"
    }
  ]
}

include {
  path = find_in_parent_folders()
}
inputs = {
  hash_key           = local.hash_key
  ttl_attribute_name = local.ttl_attribute_name
  ttl_enabled        = local.ttl_enabled
  attributes         = local.attributes
  name               = local.name
  tags               = local.common_tags
}
