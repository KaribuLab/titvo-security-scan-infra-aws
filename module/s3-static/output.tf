output "bucket_name" {
  value = aws_s3_bucket.static_bucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.static_bucket.arn
}

output "bucket_website_url" {
  value = "http://${aws_s3_bucket_website_configuration.static_bucket.website_endpoint}"
}