terraform {
  source = "${get_parent_terragrunt_dir()}/module/s3-static"
}

locals {
  common      = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  environment = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  common_tags = local.common.locals.tags
  bucket_name = "${local.common.locals.project_name}-reports-${local.environment.locals.name}${local.common.locals.bucket_suffix}"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  bucket_name = local.bucket_name
  common_tags = local.common_tags
}