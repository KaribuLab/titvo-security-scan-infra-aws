locals {
  use_bucket_uuid = get_env("USE_BUCKET_UUID", "no")
  project_name    = "tvo-security-scan"
  parameter_path  = "/tvo/security-scan"
  bucket_name     = "${local.project_name}-terraform-state${local.use_bucket_uuid == "no" ? "" : "-${uuid()}"}"
  dynamodb_table  = "${local.project_name}-tfstate-lock"
  tags_file_path  = "${get_terragrunt_dir()}/common_tags.json"
  tags = fileexists(local.tags_file_path) ? jsondecode(file(local.tags_file_path)) : {
    Project = "Titvo Security Scan"
  }
}