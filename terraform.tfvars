project_name_prefix = "cmtr-m68g13qx"
#vpc_id              = "vpc-07eb6fb25ae570eca"

vpc_cidr_block = "10.10.0.0/16"

public_subnet_a_cidr = "10.10.1.0/24"
public_subnet_b_cidr = "10.10.3.0/24"
public_subnet_c_cidr = "10.10.5.0/24"

ec2_ami = "ami-08982f1c5bf93d976"

allowed_ip_range = ["18.153.146.156/32", "186.13.120.173/32"]

aws_region   = "us-east-1"
project_id   = "cmtr-m68g13qx"
state_bucket = "cmtr-m68g13qx-tf-state-1759233674"
state_key    = "infra.tfstate"