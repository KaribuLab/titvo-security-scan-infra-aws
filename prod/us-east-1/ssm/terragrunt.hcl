terraform {
  source = "${get_parent_terragrunt_dir()}/module/ssm-parameter"
  extra_arguments "disable_backend" {
    commands  = ["init"]
    arguments = ["-backend=false"]
  }
}

locals {
  common         = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  environment    = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  region         = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region_name    = local.region.locals.name
  common_tags    = local.common.locals.tags
  base_path      = "${local.common.locals.parameter_path}/${local.environment.locals.name}/infra"
  base_directory = "${get_terragrunt_dir()}/../../.."
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
    region = "${local.region_name}"
  }
EOF
}

dependency "bucket-cli-files" {
  config_path = "${local.base_directory}/prod/us-east-1/s3/cli-files"
  mock_outputs = {
    bucket_arn  = "arn:aws:s3:::cli-files"
    bucket_id   = "cli-files"
    bucket_name = "cli-files"
  }
}

dependency "bucket-reports" {
  config_path = "${local.base_directory}/prod/us-east-1/s3/reports"
  mock_outputs = {
    bucket_arn            = "arn:aws:s3:::reports"
    bucket_name           = "reports"
    bucket_website_domain = "reports.s3-website.us-east-1.amazonaws.com"
  }
}

dependency "dynamo-api-key-table" {
  config_path = "${local.base_directory}/prod/us-east-1/account/dynamo/apikey"
  mock_outputs = {
    dynamodb_table_arn = "arn:aws:dynamodb:us-east-1:123456789012:table/apikey"
    dynamodb_table_id  = "apikey"
  }
}

dependency "dynamo-cli-files-table" {
  config_path = "${local.base_directory}/prod/us-east-1/task/dynamo/cli-files"
  mock_outputs = {
    dynamodb_table_arn = "arn:aws:dynamodb:us-east-1:123456789012:table/cli-files"
    dynamodb_table_id  = "cli-files"
  }
}

dependency "dynamo-parameter-table" {
  config_path = "${local.base_directory}/prod/us-east-1/parameter/dynamo/parameter"
  mock_outputs = {
    dynamodb_table_arn = "arn:aws:dynamodb:us-east-1:123456789012:table/parameter"
    dynamodb_table_id  = "parameter"
  }
}

dependency "dynamo-repository-table" {
  config_path = "${local.base_directory}/prod/us-east-1/account/dynamo/repository"
  mock_outputs = {
    dynamodb_table_arn = "arn:aws:dynamodb:us-east-1:123456789012:table/repository"
    dynamodb_table_id  = "repository"
  }
}

dependency "dynamo-task-table" {
  config_path = "${local.base_directory}/prod/us-east-1/task/dynamo/task"
  mock_outputs = {
    dynamodb_table_arn = "arn:aws:dynamodb:us-east-1:123456789012:table/task"
    dynamodb_table_id  = "task"
  }
}

dependency "dynamo-user-table" {
  config_path = "${local.base_directory}/prod/us-east-1/account/dynamo/user"
  mock_outputs = {
    dynamodb_table_arn = "arn:aws:dynamodb:us-east-1:123456789012:table/user"
    dynamodb_table_id  = "user"
  }
}

dependency "api-gateway-account" {
  config_path = "${local.base_directory}/prod/us-east-1/account/apigateway"
  mock_outputs = {
    api_gateway_id             = "api-gateway"
    api_gateway_authorizer_ids = ["authorizer-id"]
  }
}

dependency "api-gateway-task" {
  config_path = "${local.base_directory}/prod/us-east-1/task/apigateway"
  mock_outputs = {
    api_gateway_id                = "api-gateway"
    api_gateway_authorizer_ids    = ["authorizer-id"]
    api_gateway_api_full_endpoint = "https://api-gateway.us-east-1.amazonaws.com/v1"
  }
}

inputs = {
  base_path   = local.base_path
  common_tags = local.common_tags
  parameters = [
    {
      name  = "cli-files-bucket-arn"
      type  = "String"
      value = dependency.bucket-cli-files.outputs.bucket_arn
    },
    {
      name  = "cli-files-bucket-name"
      type  = "String"
      value = dependency.bucket-cli-files.outputs.bucket_id
    },
    {
      name  = "dynamo-api-key-table-arn"
      type  = "String"
      value = dependency.dynamo-api-key-table.outputs.dynamodb_table_arn
    },
    {
      name  = "dynamo-api-key-table-name"
      type  = "String"
      value = dependency.dynamo-api-key-table.outputs.dynamodb_table_id
    },
    {
      name  = "dynamo-cli-files-table-arn"
      type  = "String"
      value = dependency.dynamo-cli-files-table.outputs.dynamodb_table_arn
    },
    {
      name  = "dynamo-cli-files-table-name"
      type  = "String"
      value = dependency.dynamo-cli-files-table.outputs.dynamodb_table_id
    },
    {
      name  = "dynamo-configuration-table-arn"
      type  = "String"
      value = dependency.dynamo-parameter-table.outputs.dynamodb_table_arn
    },
    {
      name  = "dynamo-configuration-table-name"
      type  = "String"
      value = dependency.dynamo-parameter-table.outputs.dynamodb_table_id
    },
    {
      name  = "dynamo-parameter-table-arn"
      type  = "String"
      value = dependency.dynamo-parameter-table.outputs.dynamodb_table_arn
    },
    {
      name  = "dynamo-parameter-table-name"
      type  = "String"
      value = dependency.dynamo-parameter-table.outputs.dynamodb_table_id
    },
    {
      name  = "dynamo-hint-table-name"
      type  = "String"
      value = dependency.dynamo-repository-table.outputs.dynamodb_table_id
    },
    {
      name  = "dynamo-repository-table-arn"
      type  = "String"
      value = dependency.dynamo-repository-table.outputs.dynamodb_table_arn
    },
    {
      name  = "dynamo-task-table-arn"
      type  = "String"
      value = dependency.dynamo-task-table.outputs.dynamodb_table_arn
    },
    {
      name  = "dynamo-task-table-name"
      type  = "String"
      value = dependency.dynamo-task-table.outputs.dynamodb_table_id
    },
    {
      name  = "report-bucket-arn"
      type  = "String"
      value = dependency.bucket-reports.outputs.bucket_arn
    },
    {
      name  = "report-bucket-name"
      type  = "String"
      value = dependency.bucket-reports.outputs.bucket_name
    },
    {
      name  = "api-gateway-account-id"
      type  = "String"
      value = dependency.api-gateway-account.outputs.api_gateway_id
    },
    {
      name  = "api-gateway-account-authorizer-ids"
      type  = "String"
      value = jsonencode(dependency.api-gateway-account.outputs.api_gateway_authorizer_ids)
    },
    {
      name  = "api-gateway-task-id"
      type  = "String"
      value = dependency.api-gateway-task.outputs.api_gateway_id
    },
    {
      name  = "api-gateway-task-authorizer-ids"
      type  = "String"
      value = jsonencode(dependency.api-gateway-task.outputs.api_gateway_authorizer_ids)
    },
    {
      name  = "api-gateway-task-api-full-endpoint"
      type  = "String"
      value = dependency.api-gateway-task.outputs.api_gateway_api_full_endpoint
    },
    {
      name  = "dynamo-hint-table-arn"
      type  = "String"
      value = dependency.dynamo-repository-table.outputs.dynamodb_table_arn
    },
    {
      name  = "dynamo-user-table-name"
      type  = "String"
      value = dependency.dynamo-user-table.outputs.dynamodb_table_id
    },
    {
      name  = "dynamo-user-table-arn"
      type  = "String"
      value = dependency.dynamo-user-table.outputs.dynamodb_table_arn
    },
    {
      name  = "report-bucket-website-domain"
      type  = "String"
      value = dependency.bucket-reports.outputs.bucket_website_domain
    },
  ]
}