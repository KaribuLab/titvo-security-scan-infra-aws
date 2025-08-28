locals {
  common = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  region = read_terragrunt_config(find_in_parent_folders("region.hcl"))
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
  terraform {
    required_providers {
      aws = {
        source  = "hashicorp/aws"
        version = "${local.common.locals.provider_version}"
      }
    }
  }
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