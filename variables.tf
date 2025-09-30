variable "project_name_prefix" {
  description = "Project name prefix to be used for resource naming."
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the main VPC."
  type        = string
}

variable "availability_zones" {
  description = "Lista de Zonas de Disponibilidad para las subredes (e.g., [us-east-1a, us-east-1b, us-east-1c])."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
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
  default     = "value"
}

variable "ec2_ami" {
  description = "AMI ID para la instancia EC2."
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where security groups are created"
  type        = string
  default     = "vpc-0ccb2f5ded46ee23e"
}

variable "allowed_ip_range" {
  description = "Safe IP range (your_IP or EPAM_office-IP_range)"
  type        = list(string)
  default     = ["18.153.146.156/32"]
}



variable "aws_region" {
  description = "Region de trabajo"
  type        = string
}

variable "project_id" {
  description = "ID for Project"
  type        = string
}

variable "state_bucket" {
  description = "Estado del S3 Bucket"
  type        = string
}

variable "state_key" {
  description = "Estado de la key"
  type        = string
}


variable "ssh_key_name" {
  description = "SSH key pair name for EC2 access"
  type        = string
  default     = "cmtr-m68g13qx-keypair"
}

variable "vpc_name" {
  description = "Nombre de la VPC"
  type        = string
}

variable "public_subnet_name" {
  description = "Name tag of the public subnet to discover (e.g., cmtr-m68g13qx-public-subnet-1)."
  type        = string
}

variable "security_group_name" {
  description = "Name tag of the security group to discover (e.g., cmtr-m68g13qx-sg)."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type to provision."
  type        = string
  default     = "t3.micro"
}