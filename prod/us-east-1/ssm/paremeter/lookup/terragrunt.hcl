terraform {
  source = "git::https://github.com/KaribuLab/terraform-aws-parameter-lookup.git?ref=v0.1.0"
  extra_arguments "disable_backend" {
    commands  = ["init"]
    arguments = ["-backend=false"]
  }
}

locals {
  common      = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  environment = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  region      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  base_path   = "${local.common.locals.parameter_path}/${local.environment.locals.name}/infra"
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

inputs = {
  base_path = local.base_path
}
