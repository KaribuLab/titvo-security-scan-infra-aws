output "role_name" {
  description = "Nombre del rol IAM creado"
  value       = aws_iam_role.this.name
}

output "role_arn" {
  description = "ARN del rol IAM creado"
  value       = aws_iam_role.this.arn
}

output "policy_name" {
  description = "Nombre de la política IAM creada"
  value       = aws_iam_policy.this.name
}

output "policy_arn" {
  description = "ARN de la política IAM creada"
  value       = aws_iam_policy.this.arn
}