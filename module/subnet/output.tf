output "subnets_id" {
  value = aws_subnet.private[*].id
}

output "vpc_id" {
  value = data.aws_vpc.vpc.id
}

output "eip_public_ip" {
  value = aws_eip.nat_ip[*].public_ip
}

output "route_table_id" {
  value       = aws_route_table.private[*].id
  description = "Private Route Table ID by region and availability zone"
}