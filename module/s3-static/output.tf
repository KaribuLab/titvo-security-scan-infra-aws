output "bucket_name" {
  value = aws_s3_bucket.static_bucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.static_bucket.arn
}

output "bucket_website_domain" {
  description = "Nombre de dominio regional del bucket S3 de subida"
  value       = aws_s3_bucket.static_bucket.website_domain
}