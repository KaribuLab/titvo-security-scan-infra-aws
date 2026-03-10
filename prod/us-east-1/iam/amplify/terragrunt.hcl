terraform {
  source = "${get_parent_terragrunt_dir()}/module/iam-role"
}

locals {
  common       = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  environment  = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  common_tags  = local.common.locals.tags
  service_name = "${local.common.locals.project_name}-amplify-${local.environment.locals.name}"
}

dependency "apikey" {
  config_path = "${get_parent_terragrunt_dir()}/prod/us-east-1/dynamo/apikey"
  mock_outputs = {
    dynamodb_table_arn = "arn:aws:dynamodb:us-east-1:123456789012:table/apikey"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "repository" {
  config_path = "${get_parent_terragrunt_dir()}/prod/us-east-1/dynamo/repository"
  mock_outputs = {
    dynamodb_table_arn = "arn:aws:dynamodb:us-east-1:123456789012:table/repository"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "user" {
  config_path = "${get_parent_terragrunt_dir()}/prod/us-east-1/dynamo/user"
  mock_outputs = {
    dynamodb_table_arn = "arn:aws:dynamodb:us-east-1:123456789012:table/user"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "session" {
  config_path = "${get_parent_terragrunt_dir()}/prod/us-east-1/dynamo/session"
  mock_outputs = {
    dynamodb_table_arn = "arn:aws:dynamodb:us-east-1:123456789012:table/session"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

include {
  path = find_in_parent_folders()
}

inputs = {
  service_name     = local.service_name
  common_tags      = local.common_tags
  role_description = "Role for Amplify to access resources"
  role_policy_json = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "amplify.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  policy_description = "Policy for Amplify to access resources"
  policy_json = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem"
        ]
        Resource = [
          dependency.apikey.outputs.dynamodb_table_arn,
          "${dependency.apikey.outputs.dynamodb_table_arn}/*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "dynamodb:GetItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem"
        ]
        Resource = [
          dependency.user.outputs.dynamodb_table_arn,
          "${dependency.user.outputs.dynamodb_table_arn}/*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "dynamodb:GetItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem"
        ]
        Resource = [
          dependency.session.outputs.dynamodb_table_arn,
          "${dependency.session.outputs.dynamodb_table_arn}/*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "dynamodb:GetItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem"
        ]
        Resource = [
          dependency.repository.outputs.dynamodb_table_arn,
          "${dependency.repository.outputs.dynamodb_table_arn}/*"
        ]
      }
    ]
  })
}
