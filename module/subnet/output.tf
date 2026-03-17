output "subnets_id" {
  value = aws_subnet.private[*].id
}

output "vpc_id" {
  value = data.aws_vpc.vpc.id
}

output "route_table_id" {
  value       = aws_route_table.private[*].id
  description = "Private Route Table ID by region and availability zone"
}
