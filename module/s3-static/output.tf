output "bucket_name" {
  value = aws_s3_bucket.static_bucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.static_bucket.arn
}