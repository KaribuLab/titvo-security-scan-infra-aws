locals {
  common = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  region = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  provider_override = read_terragrunt_config(
    find_in_parent_folders("provider_override.hcl", "${get_terragrunt_dir()}/__skip.hcl"),
    { locals = { manage_required_providers = true } }
  )
  manage_required_providers = local.provider_override.locals.manage_required_providers
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.region.locals.name}"
}
EOF
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
  terraform {
    backend "s3" {}
  }
EOF
}

generate "provider_version" {
  path      = "provider_version.tf"
  if_exists = "overwrite_terragrunt"
  disable   = !local.manage_required_providers
  contents  = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "${local.common.locals.provider_version}"
    }
  }
}
EOF
}

remote_state {
  backend = "s3"
  config = {
    bucket                      = "${local.common.locals.bucket_name}"
    key                         = "${path_relative_to_include()}/terraform.tfstate"
    region                      = local.region.locals.name
    dynamodb_table              = "${local.common.locals.dynamodb_table}"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

inputs = merge(local.common.locals, local.region.locals)