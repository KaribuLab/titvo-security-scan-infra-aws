locals {
  project_name   = "tvo-security-scan"
  parameter_path = "/tvo/security-scan"
  bucket_name    = "${local.project_name}-terraform-state"
  dynamodb_table = "${local.project_name}-tfstate-lock"
  tags = {
    Project  = "Titvo Security Scan"
    Customer = "Titvo"
    Team     = "Area Creacion"
  }
}