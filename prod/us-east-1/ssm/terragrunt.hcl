terraform {
  source = "${get_parent_terragrunt_dir()}/module/ssm-parameter"
}

locals {
  common      = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  environment = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  common_tags = local.common.locals.tags
  base_path   = "${local.common.locals.parameter_path}/${local.environment.locals.name}/infra"
}

dependency "bucket-cli-files" {
  config_path = "${get_parent_terragrunt_dir()}/prod/us-east-1/s3/cli-files"
}

dependency "bucket-reports" {
  config_path = "${get_parent_terragrunt_dir()}/prod/us-east-1/s3/reports"
}

dependency "dynamo-api-key-table" {
  config_path = "${get_parent_terragrunt_dir()}/prod/us-east-1/account/dynamo/apikey"
}

dependency "dynamo-cli-files-table" {
  config_path = "${get_parent_terragrunt_dir()}/prod/us-east-1/task/dynamo/cli-files"
}

dependency "dynamo-parameter-table" {
  config_path = "${get_parent_terragrunt_dir()}/prod/us-east-1/parameter/dynamo/parameter"
}

dependency "dynamo-repository-table" {
  config_path = "${get_parent_terragrunt_dir()}/prod/us-east-1/account/dynamo/repository"
}

dependency "dynamo-task-table" {
  config_path = "${get_parent_terragrunt_dir()}/prod/us-east-1/task/dynamo/task"
}

include {
  path = find_in_parent_folders()
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
    }
  ]
}