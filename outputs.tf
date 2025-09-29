output "vpc_id" {
  description = "The unique identifier of the VPC."
  value       = aws_vpc.red_vpc.id
}

output "vpc_cidr" {
  description = "The CIDR block associated with the VPC."
  value       = aws_vpc.red_vpc.cidr_block
}

output "public_subnet_ids" {
  description = "A set of IDs for all public subnets."
  # Se usa toset() para asegurar que la salida sea un conjunto (set)
  value = toset([
    aws_subnet.red_public_a.id,
    aws_subnet.red_public_b.id,
    aws_subnet.red_public_c.id,
  ])
}

output "public_subnet_cidr_block" {
  description = "A set of CIDR's block for all public subnets."
  value = toset([
    aws_subnet.red_public_a.cidr_block,
    aws_subnet.red_public_b.cidr_block,
    aws_subnet.red_public_c.cidr_block,
  ])
}

output "public_subnet_availability_zone" {
  description = "A set of AZs for all public subnets."
  value = toset([
    aws_subnet.red_public_a.availability_zone,
    aws_subnet.red_public_b.availability_zone,
    aws_subnet.red_public_c.availability_zone,
  ])
}

output "internet_gateway_id" {
  description = "The unique identifier of the Internet Gateway."
  value       = aws_internet_gateway.red_igw.id
}

output "routing_table_id" {
  description = "The unique identifier of the routing table."
  value       = aws_route_table.red_rt.id
}
