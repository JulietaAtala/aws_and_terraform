project_name_prefix = "cmtr-m68g13qx"

allowed_ip_range = ["18.153.146.156/32", "186.13.120.173/32"]

aws_region   = "us-east-1"
project_id   = "cmtr-m68g13qx"
state_bucket = "cmtr-m68g13qx-tf-state-1759233674"
state_key    = "infra.tfstate"

ec2_ami              = "ami-09e6f87a47903347c"
public_subnet_a_cidr = "10.0.1.0/24"
public_subnet_b_cidr = "10.0.3.0/24"
public_subnet_c_cidr = "10.0.5.0/24"
vpc_cidr_block       = "10.0.0.0/16"

vpc_name            = "cmtr-m68g13qx-vpc"
public_subnet_name  = "cmtr-m68g13qx-public-subnet-1"
security_group_name = "cmtr-m68g13qx-sg"