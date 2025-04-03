resource "aws_s3_bucket" "upload_bucket" {
  bucket = var.bucket_name
  tags = var.common_tags
}

# Configuración de seguridad: bloquear acceso público por defecto
resource "aws_s3_bucket_public_access_block" "upload_bucket" {
  bucket = aws_s3_bucket.upload_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Habilitar encriptación por defecto para archivos subidos
resource "aws_s3_bucket_server_side_encryption_configuration" "upload_bucket" {
  bucket = aws_s3_bucket.upload_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Configuración CORS para permitir upload desde orígenes específicos
resource "aws_s3_bucket_cors_configuration" "upload_bucket" {
  bucket = aws_s3_bucket.upload_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST", "GET"]
    allowed_origins = var.allowed_origins != null ? var.allowed_origins : ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = var.cors_max_age_seconds
  }
}

# Configuración opcional de ciclo de vida para gestionar archivos subidos
resource "aws_s3_bucket_lifecycle_configuration" "upload_bucket" {
  count = var.enable_lifecycle_rules ? 1 : 0
  
  bucket = aws_s3_bucket.upload_bucket.id

  rule {
    id = "expire-temp-uploads"
    status = "Enabled"

    expiration {
      days = var.temp_file_expiration_days != null ? var.temp_file_expiration_days : 7
    }

    filter {
      prefix = var.temp_files_prefix
    }
  }
}