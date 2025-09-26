output "vpc_id" {
  description = "ID de la VPC creada."
  value       = aws_vpc.red_vpc.id
}

output "internet_gateway_id" {
  description = "ID del Internet Gateway."
  value       = aws_internet_gateway.red_igw.id
}

output "public_subnet_ids" {
  description = "Lista de IDs de las subredes públicas."
  value       = [
    aws_subnet.red_public_a.id,
    aws_subnet.red_public_b.id,
    aws_subnet.red_public_c.id,
  ]
}