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
      path        = "vpc/subnet/private/subnets_id"
      value       = jsonencode(dependency.subnet.outputs.subnets_id)
      type        = "String"
      tier        = "Standard"
      description = "Private subnets IDs"
    },
    {
      path        = "vpc/subnet/private/routes_table_id"
      value       = jsonencode(dependency.subnet.outputs.route_table_id)
      type        = "String"
      tier        = "Standard"
      description = "Private route table IDs"
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
    }
  ]
}
