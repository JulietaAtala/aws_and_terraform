resource "aws_instance" "app" {
  ami           = "ami-08c40ec9ead489470"
  instance_type = "t2.micro"

  subnet_id              = data.terraform_remote_state.base_infra.outputs.public_subnet_id
  vpc_security_group_ids = [data.terraform_remote_state.base_infra.outputs.security_group_id]

  tags = {
    Terraform = "true"
    Project   = var.project_id
  }
}
