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

variable "public_instance_id" {
  description = "ID de la interfaz de red (ENI) de la instancia pública (cmtr-m68g13qx-public-instance)."
  type        = string
}

variable "private_instance_id" {
  description = "ID de la interfaz de red (ENI) de la instancia privada (i-0bae336f280f2661a)."
  type        = string
}