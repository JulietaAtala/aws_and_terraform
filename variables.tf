variable "project_name_prefix" {
  description = "Project name prefix to be used for resource naming."
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the main VPC."
  type        = string
}

variable "public_subnet_a_cidr" {
  description = "Bloque CIDR para la subred pública en us-east-1a."
  type        = string
}

variable "public_subnet_b_cidr" {
  description = "Bloque CIDR para la subred pública en us-east-1b."
  type        = string
}

variable "public_subnet_c_cidr" {
  description = "Bloque CIDR para la subred pública en us-east-1c."
  type        = string
}

variable "ssh_key" {
  description = "Provides custom public SSH key."
  type        = string
}

variable "ec2_ami" {
  description = "AMI ID para la instancia EC2."
  type        = string
}