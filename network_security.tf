resource "aws_security_group" "ssh_sg" {
  name        = "${var.project_name_prefix}-ssh-sg"
  description = "Allow SSH (22) and ICMP from allowed IP range"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_range
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = var.allowed_ip_range
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project = var.project_name_prefix
  }
}

resource "aws_security_group" "public_http_sg" {
  name        = "${var.project_name_prefix}-public-http-sg"
  description = "Allow HTTP (80) and ICMP from allowed IP range"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_range
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = var.allowed_ip_range
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project = var.project_name_prefix
  }
}


resource "aws_security_group" "private_http_sg" {
  name        = "${var.project_name_prefix}-private-http-sg"
  description = "Allow HTTP (8080) and ICMP from Public HTTP SG"
  vpc_id      = var.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Project = var.project_name_prefix
  }
}

resource "aws_security_group_rule" "private_http_sg_http" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.public_http_sg.id
  security_group_id        = aws_security_group.private_http_sg.id
}

resource "aws_security_group_rule" "private_http_sg_icmp" {
  type                     = "ingress"
  from_port                = -1
  to_port                  = -1
  protocol                 = "icmp"
  source_security_group_id = aws_security_group.public_http_sg.id
  security_group_id        = aws_security_group.private_http_sg.id
}


resource "aws_network_interface_sg_attachment" "public_ssh_attach" {
  security_group_id    = aws_security_group.ssh_sg.id
  network_interface_id = var.public_instance_id
}

resource "aws_network_interface_sg_attachment" "public_http_attach" {
  security_group_id    = aws_security_group.public_http_sg.id
  network_interface_id = var.public_instance_id
}


resource "aws_network_interface_sg_attachment" "private_ssh_attach" {
  security_group_id    = aws_security_group.ssh_sg.id
  network_interface_id = var.private_instance_id
}

resource "aws_network_interface_sg_attachment" "private_http_attach" {
  security_group_id    = aws_security_group.private_http_sg.id
  network_interface_id = var.private_instance_id
}
