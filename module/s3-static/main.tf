resource "aws_s3_bucket" "static_bucket" {
  bucket = var.bucket_name
  tags = var.common_tags
}

# Habilitar el alojamiento de sitio web estático
resource "aws_s3_bucket_website_configuration" "static_bucket" {
  bucket = aws_s3_bucket.static_bucket.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

# Configurar el acceso público al bucket
resource "aws_s3_bucket_public_access_block" "static_bucket" {
  bucket = aws_s3_bucket.static_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Política de bucket para permitir acceso público de lectura
resource "aws_s3_bucket_policy" "static_bucket" {
  bucket = aws_s3_bucket.static_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.static_bucket.arn}/*"
      }
    ]
  })
}

# Configuración de CORS para permitir acceso desde dominios específicos
resource "aws_s3_bucket_cors_configuration" "static_bucket" {
  bucket = aws_s3_bucket.static_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]  # En producción, deberías especificar los dominios exactos
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}