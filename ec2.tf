resource "aws_security_group" "cmtr_sg" {
  name        = "${var.project_id}-sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.red_vpc.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}

#resource "aws_instance" "cmtr_ec2" {
#ami           = var.ec2_ami
#instance_type = "t2.micro"
#key_name      = aws_key_pair.cmtr_keypair.key_name

#vpc_security_group_ids = [aws_security_group.cmtr_sg.id]

#subnet_id = aws_subnet.red_public_a.id

#associate_public_ip_address = true

#tags = merge(local.tags, {
#  Name = "${local.name_for}-ec2"
#})
#}
