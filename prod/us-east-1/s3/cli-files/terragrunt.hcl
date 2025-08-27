terraform {
  source = "${get_parent_terragrunt_dir()}/module/s3-upload"
}

locals {
  common      = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  environment = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  common_tags = local.common.locals.tags
  bucket_name = "${local.common.locals.project_name}-cli-files-${local.environment.locals.name}${local.common.locals.bucket_suffix}"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  bucket_name               = local.bucket_name
  common_tags               = local.common_tags
  cors_max_age_seconds      = 3600
  enable_lifecycle_rules    = true
  temp_file_expiration_days = 1
}