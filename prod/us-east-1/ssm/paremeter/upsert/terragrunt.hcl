terraform {
  source = "git::https://github.com/KaribuLab/terraform-aws-parameter-upsert.git?ref=v0.5.6"
}

locals {
  common      = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  environment = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  region      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  base_path   = "${local.common.locals.parameter_path}/${local.environment.locals.name}/infra"
}

dependency "bitbucket_code_insights_input" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/sqs/bitbucket-code-insights/input"
  mock_outputs = {
    queue_arn  = "arn:aws:sqs:us-east-1:601238391153:test"
    queue_url  = "https://sqs.us-east-1.amazonaws.com/601238391153/test"
    queue_name = "test"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "git_commit_files_input" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/sqs/git-commit-files/input"
  mock_outputs = {
    queue_arn  = "arn:aws:sqs:us-east-1:601238391153:test"
    queue_url  = "https://sqs.us-east-1.amazonaws.com/601238391153/test"
    queue_name = "test"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "github_issue_input" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/sqs/github-issue/input"
  mock_outputs = {
    queue_arn  = "arn:aws:sqs:us-east-1:601238391153:test"
    queue_url  = "https://sqs.us-east-1.amazonaws.com/601238391153/test"
    queue_name = "test"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "issue_report_input" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/sqs/issue-report/input"
  mock_outputs = {
    queue_arn  = "arn:aws:sqs:us-east-1:601238391153:test"
    queue_url  = "https://sqs.us-east-1.amazonaws.com/601238391153/test"
    queue_name = "test"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "gateway_output" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/sqs/gateway/output"
  mock_outputs = {
    queue_arn  = "arn:aws:sqs:us-east-1:601238391153:test"
    queue_url  = "https://sqs.us-east-1.amazonaws.com/601238391153/test"
    queue_name = "test"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "ecs" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/ecs"
  mock_outputs = {
    cluster_name = "ecs-cluster-test"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "subnet" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/vpc/subnet/private"
  mock_outputs = {
    subnets_id = [
      "subnet-00000000000000000",
      "subnet-00000000000000000",
      "subnet-00000000000000000"
    ]
    route_table_id = [
      "rtb-00000000000000000"
    ]
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "security_group" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/vpc/security-group"
  mock_outputs = {
    security_group_id = "sg-00000000000000000"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "cloudmap" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/cloudmap"
  mock_outputs = {
    cloudmap_id   = "ns-00000000000000000"
    cloudmap_arn  = "arn:aws:servicediscovery:us-west-2:000000000000:namespace/ns-00000000000000000"
    cloudmap_name = "internal.titvo.com"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "eventbridge" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/eventbridge"
  mock_outputs = {
    eventbus_arn  = "arn:aws:events:us-west-2:000000000000:event-bus/ia-eventbus-test"
    eventbus_name = "ia-eventbus-test"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "s3_cli_files" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/s3/cli-files"
  mock_outputs = {
    bucket_arn = "arn:aws:s3:::test-bucket"
    bucket_id  = "test-bucket"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "s3_reports" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/s3/reports"
  mock_outputs = {
    bucket_arn       = "arn:aws:s3:::test-reports"
    bucket_name      = "test-reports"
    bucket_website_url = "http://test-reports.s3-website-us-east-1.amazonaws.com"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "s3_git_commit_files" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/s3/git-commit-files"
  mock_outputs = {
    bucket_arn = "arn:aws:s3:::test-git-commit-files"
    bucket_id  = "test-git-commit-files"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "dynamo_apikey" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/dynamo/apikey"
  mock_outputs = {
    dynamodb_table_arn = "arn:aws:dynamodb:us-east-1:000000000000:table/test-apikey"
    dynamodb_table_id  = "test-apikey"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "dynamo_cli_files" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/dynamo/cli-files"
  mock_outputs = {
    dynamodb_table_arn = "arn:aws:dynamodb:us-east-1:000000000000:table/test-cli-files"
    dynamodb_table_id  = "test-cli-files"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "dynamo_jobs" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/dynamo/jobs"
  mock_outputs = {
    dynamodb_table_arn = "arn:aws:dynamodb:us-east-1:000000000000:table/test-jobs"
    dynamodb_table_id  = "test-jobs"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "dynamo_parameter" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/dynamo/parameter"
  mock_outputs = {
    dynamodb_table_arn = "arn:aws:dynamodb:us-east-1:000000000000:table/test-parameter"
    dynamodb_table_id  = "test-parameter"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "dynamo_prompt" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/dynamo/prompt"
  mock_outputs = {
    dynamodb_table_arn = "arn:aws:dynamodb:us-east-1:000000000000:table/test-prompt"
    dynamodb_table_id  = "test-prompt"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "dynamo_repository" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/dynamo/repository"
  mock_outputs = {
    dynamodb_table_arn = "arn:aws:dynamodb:us-east-1:000000000000:table/test-repository"
    dynamodb_table_id  = "test-repository"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "dynamo_scan" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/dynamo/scan"
  mock_outputs = {
    dynamodb_table_arn = "arn:aws:dynamodb:us-east-1:000000000000:table/test-scan"
    dynamodb_table_id  = "test-scan"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "dynamo_session" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/dynamo/session"
  mock_outputs = {
    dynamodb_table_arn = "arn:aws:dynamodb:us-east-1:000000000000:table/test-session"
    dynamodb_table_id  = "test-session"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "dynamo_task" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/dynamo/task"
  mock_outputs = {
    dynamodb_table_arn = "arn:aws:dynamodb:us-east-1:000000000000:table/test-task"
    dynamodb_table_id  = "test-task"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "dynamo_user" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/dynamo/user"
  mock_outputs = {
    dynamodb_table_arn = "arn:aws:dynamodb:us-east-1:000000000000:table/test-user"
    dynamodb_table_id  = "test-user"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "apigateway_task" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/apigateway/task"
  mock_outputs = {
    api_gateway_id = "abc123def456"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

include {
  path = find_in_parent_folders()
}

inputs = {
  base_path      = local.base_path
  binary_version = "v0.5.6"
  parameters = [
    {
      path        = "sqs/mcp/bitbucket-code-insights/input/queue_arn"
      value       = dependency.bitbucket_code_insights_input.outputs.queue_arn
      type        = "String"
      tier        = "Standard"
      description = "SQS queue ARN for bitbucket-code-insights input"
    },
    {
      path        = "sqs/mcp/bitbucket-code-insights/input/queue_name"
      value       = dependency.bitbucket_code_insights_input.outputs.queue_name
      type        = "String"
      tier        = "Standard"
      description = "SQS queue name for bitbucket-code-insights input"
    },
    {
      path        = "sqs/mcp/bitbucket-code-insights/input/queue_url"
      value       = dependency.bitbucket_code_insights_input.outputs.queue_url
      type        = "String"
      tier        = "Standard"
      description = "SQS queue url for bitbucket-code-insights input"
    },
    {
      path        = "sqs/mcp/git-commit-files/input/queue_arn"
      value       = dependency.git_commit_files_input.outputs.queue_arn
      type        = "String"
      tier        = "Standard"
      description = "SQS queue ARN for git-commit-files input"
    },
    {
      path        = "sqs/mcp/git-commit-files/input/queue_name"
      value       = dependency.git_commit_files_input.outputs.queue_name
      type        = "String"
      tier        = "Standard"
      description = "SQS queue name for git-commit-files input"
    },
    {
      path        = "sqs/mcp/git-commit-files/input/queue_url"
      value       = dependency.git_commit_files_input.outputs.queue_url
      type        = "String"
      tier        = "Standard"
      description = "SQS queue url for git-commit-files input"
    },
    {
      path        = "sqs/mcp/github-issue/input/queue_arn"
      value       = dependency.github_issue_input.outputs.queue_arn
      type        = "String"
      tier        = "Standard"
      description = "SQS queue ARN for github-issue input"
    },
    {
      path        = "sqs/mcp/github-issue/input/queue_name"
      value       = dependency.github_issue_input.outputs.queue_name
      type        = "String"
      tier        = "Standard"
      description = "SQS queue name for github-issue input"
    },
    {
      path        = "sqs/mcp/github-issue/input/queue_url"
      value       = dependency.github_issue_input.outputs.queue_url
      type        = "String"
      tier        = "Standard"
      description = "SQS queue url for github-issue input"
    },
    {
      path        = "sqs/mcp/issue-report/input/queue_arn"
      value       = dependency.issue_report_input.outputs.queue_arn
      type        = "String"
      tier        = "Standard"
      description = "SQS queue ARN for issue-report input"
    },
    {
      path        = "sqs/mcp/issue-report/input/queue_name"
      value       = dependency.issue_report_input.outputs.queue_name
      type        = "String"
      tier        = "Standard"
      description = "SQS queue name for issue-report input"
    },
    {
      path        = "sqs/mcp/issue-report/input/queue_url"
      value       = dependency.issue_report_input.outputs.queue_url
      type        = "String"
      tier        = "Standard"
      description = "SQS queue url for issue-report input"
    },
    {
      path        = "sqs/mcp/gateway/output/queue_arn"
      value       = dependency.gateway_output.outputs.queue_arn
      type        = "String"
      tier        = "Standard"
      description = "SQS queue ARN for gateway output"
    },
    {
      path        = "sqs/mcp/gateway/output/queue_name"
      value       = dependency.gateway_output.outputs.queue_name
      type        = "String"
      tier        = "Standard"
      description = "SQS queue name for gateway output"
    },
    {
      path        = "sqs/mcp/gateway/output/queue_url"
      value       = dependency.gateway_output.outputs.queue_url
      type        = "String"
      tier        = "Standard"
      description = "SQS queue url for gateway output"
    },
    {
      path        = "ecs/cluster_name"
      value       = dependency.ecs.outputs.cluster_name
      type        = "String"
      tier        = "Standard"
      description = "ECS cluster name"
    },
    {
      path        = "vpc/subnets/private"
      value       = jsonencode(dependency.subnet.outputs.subnets_id)
      type        = "String"
      tier        = "Standard"
      description = "Private subnets IDs"
    },
    {
      path        = "vpc/security-group/security_group_id"
      value       = dependency.security_group.outputs.security_group_id
      type        = "String"
      tier        = "Standard"
      description = "Security group ID"
    },
    {
      path        = "cloudmap/cloudmap_id"
      value       = dependency.cloudmap.outputs.cloudmap_id
      type        = "String"
      tier        = "Standard"
      description = "CloudMap ID"
    },
    {
      path        = "cloudmap/cloudmap_arn"
      value       = dependency.cloudmap.outputs.cloudmap_arn
      type        = "String"
      tier        = "Standard"
      description = "CloudMap ARN"
    },
    {
      path        = "eventbridge/eventbus_arn"
      value       = dependency.eventbridge.outputs.eventbus_arn
      type        = "String"
      tier        = "Standard"
      description = "EventBus ARN"
    },
    {
      path        = "eventbridge/eventbus_name"
      value       = dependency.eventbridge.outputs.eventbus_name
      type        = "String"
      tier        = "Standard"
      description = "EventBus name"
    },
    {
      path        = "s3/cli-files/bucket_arn"
      value       = dependency.s3_cli_files.outputs.bucket_arn
      type        = "String"
      tier        = "Standard"
      description = "S3 CLI files bucket ARN"
    },
    {
      path        = "s3/cli-files/bucket_name"
      value       = dependency.s3_cli_files.outputs.bucket_id
      type        = "String"
      tier        = "Standard"
      description = "S3 CLI files bucket name"
    },
    {
      path        = "s3/reports/bucket_arn"
      value       = dependency.s3_reports.outputs.bucket_arn
      type        = "String"
      tier        = "Standard"
      description = "S3 reports bucket ARN"
    },
    {
      path        = "s3/reports/bucket_name"
      value       = dependency.s3_reports.outputs.bucket_name
      type        = "String"
      tier        = "Standard"
      description = "S3 reports bucket name"
    },
    {
      path        = "s3/reports/bucket_website_url"
      value       = dependency.s3_reports.outputs.bucket_website_url
      type        = "String"
      tier        = "Standard"
      description = "S3 reports bucket website URL"
    },
    {
      path        = "s3/git-commit-files/bucket_arn"
      value       = dependency.s3_git_commit_files.outputs.bucket_arn
      type        = "String"
      tier        = "Standard"
      description = "S3 git-commit-files bucket ARN"
    },
    {
      path        = "s3/git-commit-files/bucket_name"
      value       = dependency.s3_git_commit_files.outputs.bucket_id
      type        = "String"
      tier        = "Standard"
      description = "S3 git-commit-files bucket name"
    },
    {
      path        = "dynamo/apikey-table-arn"
      value       = dependency.dynamo_apikey.outputs.dynamodb_table_arn
      type        = "String"
      tier        = "Standard"
      description = "DynamoDB apikey table ARN"
    },
    {
      path        = "dynamo/apikey-table-name"
      value       = dependency.dynamo_apikey.outputs.dynamodb_table_id
      type        = "String"
      tier        = "Standard"
      description = "DynamoDB apikey table name"
    },
    {
      path        = "dynamo/cli-files-table-arn"
      value       = dependency.dynamo_cli_files.outputs.dynamodb_table_arn
      type        = "String"
      tier        = "Standard"
      description = "DynamoDB cli-files table ARN"
    },
    {
      path        = "dynamo/cli-files-table-name"
      value       = dependency.dynamo_cli_files.outputs.dynamodb_table_id
      type        = "String"
      tier        = "Standard"
      description = "DynamoDB cli-files table name"
    },
    {
      path        = "dynamo/jobs-table-arn"
      value       = dependency.dynamo_jobs.outputs.dynamodb_table_arn
      type        = "String"
      tier        = "Standard"
      description = "DynamoDB jobs table ARN"
    },
    {
      path        = "dynamo/jobs-table-name"
      value       = dependency.dynamo_jobs.outputs.dynamodb_table_id
      type        = "String"
      tier        = "Standard"
      description = "DynamoDB jobs table name"
    },
    {
      path        = "dynamo/parameter-table-arn"
      value       = dependency.dynamo_parameter.outputs.dynamodb_table_arn
      type        = "String"
      tier        = "Standard"
      description = "DynamoDB parameter table ARN"
    },
    {
      path        = "dynamo/parameter-table-name"
      value       = dependency.dynamo_parameter.outputs.dynamodb_table_id
      type        = "String"
      tier        = "Standard"
      description = "DynamoDB parameter table name"
    },
    {
      path        = "dynamo/prompt-table-arn"
      value       = dependency.dynamo_prompt.outputs.dynamodb_table_arn
      type        = "String"
      tier        = "Standard"
      description = "DynamoDB prompt table ARN"
    },
    {
      path        = "dynamo/prompt-table-name"
      value       = dependency.dynamo_prompt.outputs.dynamodb_table_id
      type        = "String"
      tier        = "Standard"
      description = "DynamoDB prompt table name"
    },
    {
      path        = "dynamo/repository-table-arn"
      value       = dependency.dynamo_repository.outputs.dynamodb_table_arn
      type        = "String"
      tier        = "Standard"
      description = "DynamoDB repository table ARN"
    },
    {
      path        = "dynamo/repository-table-name"
      value       = dependency.dynamo_repository.outputs.dynamodb_table_id
      type        = "String"
      tier        = "Standard"
      description = "DynamoDB repository table name"
    },
    {
      path        = "dynamo/scan-table-arn"
      value       = dependency.dynamo_scan.outputs.dynamodb_table_arn
      type        = "String"
      tier        = "Standard"
      description = "DynamoDB scan table ARN"
    },
    {
      path        = "dynamo/scan-table-name"
      value       = dependency.dynamo_scan.outputs.dynamodb_table_id
      type        = "String"
      tier        = "Standard"
      description = "DynamoDB scan table name"
    },
    {
      path        = "dynamo/session-table-arn"
      value       = dependency.dynamo_session.outputs.dynamodb_table_arn
      type        = "String"
      tier        = "Standard"
      description = "DynamoDB session table ARN"
    },
    {
      path        = "dynamo/session-table-name"
      value       = dependency.dynamo_session.outputs.dynamodb_table_id
      type        = "String"
      tier        = "Standard"
      description = "DynamoDB session table name"
    },
    {
      path        = "dynamo/task-table-arn"
      value       = dependency.dynamo_task.outputs.dynamodb_table_arn
      type        = "String"
      tier        = "Standard"
      description = "DynamoDB task table ARN"
    },
    {
      path        = "dynamo/task-table-name"
      value       = dependency.dynamo_task.outputs.dynamodb_table_id
      type        = "String"
      tier        = "Standard"
      description = "DynamoDB task table name"
    },
    {
      path        = "dynamo/user-table-arn"
      value       = dependency.dynamo_user.outputs.dynamodb_table_arn
      type        = "String"
      tier        = "Standard"
      description = "DynamoDB user table ARN"
    },
    {
      path        = "dynamo/user-table-name"
      value       = dependency.dynamo_user.outputs.dynamodb_table_id
      type        = "String"
      tier        = "Standard"
      description = "DynamoDB user table name"
    },
    {
      path        = "apigateway/task/api_gateway_id"
      value       = dependency.apigateway_task.outputs.api_gateway_id
      type        = "String"
      tier        = "Standard"
      description = "API Gateway task ID"
    }
  ]
}
