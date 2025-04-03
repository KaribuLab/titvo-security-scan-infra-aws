output "bucket_id" {
  description = "ID del bucket S3 de subida"
  value       = aws_s3_bucket.upload_bucket.id
}

output "bucket_arn" {
  description = "ARN del bucket S3 de subida"
  value       = aws_s3_bucket.upload_bucket.arn
}

output "bucket_domain_name" {
  description = "Nombre de dominio del bucket S3 de subida"
  value       = aws_s3_bucket.upload_bucket.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "Nombre de dominio regional del bucket S3 de subida"
  value       = aws_s3_bucket.upload_bucket.bucket_regional_domain_name
} 