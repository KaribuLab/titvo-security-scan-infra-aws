resource "aws_service_discovery_private_dns_namespace" "cloudmap" {
  name        = var.namespace
  description = var.description
  vpc         = var.vpc_id
  tags        = var.tags
}
