locals {
  project_name    = get_env("PROJECT_NAME", "tvo-security-scan")
  parameter_path  = get_env("PARAMETER_PATH", "/tvo/security-scan")
  use_bucket_uuid = get_env("USE_BUCKET_UUID", "no")
  bucket_name     = get_env("BUCKET_STATE_NAME", "${local.project_name}-terraform-state${local.use_bucket_uuid == "no" ? "" : "-${uuid()}"}")
  dynamodb_table  = "${local.project_name}-tfstate-lock"
  tags_file_path  = "${get_terragrunt_dir()}/common_tags.json"
  tags = fileexists(local.tags_file_path) ? jsondecode(file(local.tags_file_path)) : {
    Project  = "Titvo Security Scan"
    Customer = "Titvo"
    Team     = "Area Creacion"
  }
}