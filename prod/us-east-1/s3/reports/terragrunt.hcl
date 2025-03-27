terraform {
  source = "${get_parent_terragrunt_dir()}/module/s3-static"
}

locals {
  common      = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  environment = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  common_tags = local.common.locals.tags
  name        = "${local.common.locals.project_name}-reports-${local.environment.locals.name}"
}

inputs = {
  bucket_name = "reports-${local.context.locals.name}"
  common_tags = local.common.locals.tags
}