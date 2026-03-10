# Titvo Security Scan Infra AWS (Agent Reference)

## Purpose

Infrastructure as Code (IaC) repository that deploys **Titvo Security Scan platform infrastructure on AWS** using:

- Terraform
- Terragrunt

The repository provisions core platform resources including:

- DynamoDB
- S3
- SQS
- API Gateway
- EventBridge
- SSM Parameter Store
- VPC
- IAM
- ECS services

---

Agents must follow the rules defined in the `rules/` directory.

## Mandatory Rules

- rules/ephemeral-worktrees.md
- rules/checkpoint.md
- rules/commit-style.md
- rules/terragrunt/validation-and-formatting.md
