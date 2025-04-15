locals {
  # Generar nombre del rol con sufijo _role
  role_name = "${var.service_name}-role"

  # Generar nombre de la política
  policy_name = "${var.service_name}-policy"
}

resource "aws_iam_role" "this" {
  name                 = local.role_name
  description          = var.role_description

  # Usamos el documento de política de confianza proporcionado
  assume_role_policy = var.role_policy_json

  tags = var.tags
}

resource "aws_iam_policy" "this" {
  name        = local.policy_name
  description = var.policy_description

  # Usamos el documento de política proporcionado
  policy = var.policy_json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}
