locals {
  account_id       = get_env("AWS_ACCOUNT_ID", "")
  bucket_suffix    = local.account_id == "" ? "" : "-${local.account_id}"
  project_name     = "tvo-security-scan"
  parameter_path   = "/tvo/security-scan"
  bucket_name      = "${local.project_name}-terraform-state${local.bucket_suffix}"
  dynamodb_table   = "${local.project_name}-tfstate-lock"
  tags_file_path   = "${get_terragrunt_dir()}/common_tags.json"
  provider_version = "6.7.0"
  tags = fileexists(local.tags_file_path) ? jsondecode(file(local.tags_file_path)) : {
    Project = "Titvo Security Scan Infrastructure"
  }
}