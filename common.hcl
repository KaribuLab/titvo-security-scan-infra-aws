locals {
  project_name   = get_env("PROJECT_NAME", "titvo-security-scan")
  parameter_path = get_env("PARAMETER_PATH", "/titvo/security-scan")
  bucket_name    = get_env("BUCKET_STATE_NAME", "${local.project_name}-terraform-state")
  dynamodb_table = "${local.project_name}-tfstate-lock"
  tags = {
    Project  = "Titvo Security Scan"
    Customer = "Titvo"
    Team     = "Area Creacion"
  }
}