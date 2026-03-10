terraform {
  source = "git::https://github.com/KaribuLab/terraform-aws-eventbridge-sqs.git?ref=v0.3.0"
}

locals {
  common          = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  environment     = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  region          = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  customer_prefix = local.common.locals.project_prefix
  eventbus_name   = "${local.customer_prefix}-ia-eventbus-${local.environment.locals.name}"
  common_tags = merge(local.common.locals.tags, {
    Name = local.eventbus_name
  })
}

dependency "bitbucket_code_insights_input" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/sqs/bitbucket-code-insights/input"
  mock_outputs = {
    queue_arn = "arn:aws:sqs:us-east-1:601238391153:test"
    queue_url = "https://sqs.us-east-1.amazonaws.com/601238391153/test"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "bitbucket_code_insights_output" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/sqs/bitbucket-code-insights/output"
  mock_outputs = {
    queue_arn = "arn:aws:sqs:us-east-1:601238391153:test"
    queue_url = "https://sqs.us-east-1.amazonaws.com/601238391153/test"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "git_commit_files_input" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/sqs/git-commit-files/input"
  mock_outputs = {
    queue_arn = "arn:aws:sqs:us-east-1:601238391153:test"
    queue_url = "https://sqs.us-east-1.amazonaws.com/601238391153/test"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "git_commit_files_output" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/sqs/git-commit-files/output"
  mock_outputs = {
    queue_arn = "arn:aws:sqs:us-east-1:601238391153:test"
    queue_url = "https://sqs.us-east-1.amazonaws.com/601238391153/test"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "github_issue_input" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/sqs/github-issue/input"
  mock_outputs = {
    queue_arn = "arn:aws:sqs:us-east-1:601238391153:test"
    queue_url = "https://sqs.us-east-1.amazonaws.com/601238391153/test"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "github_issue_output" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/sqs/github-issue/output"
  mock_outputs = {
    queue_arn = "arn:aws:sqs:us-east-1:601238391153:test"
    queue_url = "https://sqs.us-east-1.amazonaws.com/601238391153/test"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "issue_report_input" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/sqs/issue-report/input"
  mock_outputs = {
    queue_arn = "arn:aws:sqs:us-east-1:601238391153:test"
    queue_url = "https://sqs.us-east-1.amazonaws.com/601238391153/test"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "issue_report_output" {
  config_path = "${get_parent_terragrunt_dir()}/${local.environment.locals.name}/us-east-1/sqs/issue-report/output"
  mock_outputs = {
    queue_arn = "arn:aws:sqs:us-east-1:601238391153:test"
    queue_url = "https://sqs.us-east-1.amazonaws.com/601238391153/test"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

include {
  path = find_in_parent_folders()
}

inputs = {
  eventbus_name = local.eventbus_name
  rules = [
    {
      name        = "bitbucket-code-insights-input"
      description = "Send bitbucket code insights input events to sqs"
      event_pattern = jsonencode({
        source      = ["mcp.tool.bitbucket.code-insights"]
        detail-type = ["input"]
      })
      sqs_queue_arn = dependency.bitbucket_code_insights_input.outputs.queue_arn
      sqs_queue_url = dependency.bitbucket_code_insights_input.outputs.queue_url
    },
    {
      name        = "git-commit-files-input"
      description = "Send git commit files input events to sqs"
      event_pattern = jsonencode({
        source      = ["mcp.tool.git.commit-files"]
        detail-type = ["input"]
      })
      sqs_queue_arn = dependency.git_commit_files_input.outputs.queue_arn
      sqs_queue_url = dependency.git_commit_files_input.outputs.queue_url
    },
    {
      name        = "issue-report-input"
      description = "Send issue report input events to sqs"
      event_pattern = jsonencode({
        source      = ["mcp.tool.issue-report"]
        detail-type = ["input"]
      })
      sqs_queue_arn = dependency.issue_report_input.outputs.queue_arn
      sqs_queue_url = dependency.issue_report_input.outputs.queue_url
    },
    {
      name        = "github-issue-input"
      description = "Send github issue input events to sqs"
      event_pattern = jsonencode({
        source      = ["mcp.tool.github-issue"]
        detail-type = ["input"]
      })
      sqs_queue_arn = dependency.github_issue_input.outputs.queue_arn
      sqs_queue_url = dependency.github_issue_input.outputs.queue_url
    },
    {
      name        = "bitbucket-code-insights-output"
      description = "Send bitbucket code insights output events to sqs"
      event_pattern = jsonencode({
        source      = ["mcp.tool.bitbucket.code-insights"]
        detail-type = ["output"]
      })
      sqs_queue_arn = dependency.bitbucket_code_insights_output.outputs.queue_arn
      sqs_queue_url = dependency.bitbucket_code_insights_output.outputs.queue_url
    },
    {
      name        = "git-commit-files-output"
      description = "Send git commit files output events to sqs"
      event_pattern = jsonencode({
        source      = ["mcp.tool.git.commit-files"]
        detail-type = ["output"]
      })
      sqs_queue_arn = dependency.git_commit_files_output.outputs.queue_arn
      sqs_queue_url = dependency.git_commit_files_output.outputs.queue_url
    },
    {
      name        = "issue-report-output"
      description = "Send issue report output events to sqs"
      event_pattern = jsonencode({
        source      = ["mcp.tool.issue-report"]
        detail-type = ["output"]
      })
      sqs_queue_arn = dependency.issue_report_output.outputs.queue_arn
      sqs_queue_url = dependency.issue_report_output.outputs.queue_url
    },
    {
      name        = "github-issue-output"
      description = "Send github issue output events to sqs"
      event_pattern = jsonencode({
        source      = ["mcp.tool.github-issue"]
        detail-type = ["output"]
      })
      sqs_queue_arn = dependency.github_issue_output.outputs.queue_arn
      sqs_queue_url = dependency.github_issue_output.outputs.queue_url
    }
  ]
  tags = local.common_tags
}
