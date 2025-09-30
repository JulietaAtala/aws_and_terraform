locals {
  project_prefix = "cmtr-m68g13qx"
  ami_id         = "ami-09e6f87a47903347c"
  vpc_id         = "vpc-008ada97375a3f064"
  public_subnets = [
    "10.0.1.0/24",
    "10.0.3.0/24"
  ]
  private_subnets = [
    "10.0.2.0/24",
    "10.0.4.0/24"
  ]
  tags = {
    Terraform = "true"
    Project   = local.project_prefix
  }
}


data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["cmtr-m68g13qx-vpc"]
  }
}


data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = ["cmtr-m68g13qx-public_subnet"]
  }
}

data "aws_security_group" "ec2_sg" {
  vpc_id = data.aws_vpc.selected.id
  filter {
    name   = "tag:Name"
    values = ["${local.project_prefix}-ec2_sg"]
  }
}

data "aws_security_group" "http_sg" {
  vpc_id = data.aws_vpc.selected.id
  filter {
    name   = "tag:Name"
    values = ["${local.project_prefix}-http_sg"]
  }
}

data "aws_security_group" "sglb" {
  vpc_id = data.aws_vpc.selected.id
  filter {
    name   = "tag:Name"
    values = ["${local.project_prefix}-sglb"]
  }
}

data "aws_iam_instance_profile" "instance_profile" {
  name = "${local.project_prefix}-instance_profile"
}

resource "aws_launch_template" "template" {
  name_prefix   = "${local.project_prefix}-template"
  image_id      = local.ami_id
  instance_type = "t3.micro"
  key_name      = var.ssh_key_name
  user_data     = base64encode(file("startup_script.sh"))

  iam_instance_profile {
    arn = data.aws_iam_instance_profile.instance_profile.arn
  }

  network_interfaces {
    delete_on_termination = true
    security_groups       = [data.aws_security_group.ec2_sg.id, data.aws_security_group.http_sg.id]
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  tag_specifications {
    resource_type = "instance"
    tags          = local.tags
  }

  tags = local.tags
}

resource "aws_lb" "loadbalancer" {
  name               = "${local.project_prefix}-loadbalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.sglb.id]
  subnets            = data.aws_subnets.public.ids

  tags = local.tags
}

resource "aws_lb_target_group" "target_group" {
  name     = "${local.project_prefix}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.selected.id

  health_check {
    path = "/"
  }

  tags = local.tags
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.loadbalancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_autoscaling_group" "asg" {
  name                = "${local.project_prefix}-asg"
  desired_capacity    = 2
  max_size            = 2
  min_size            = 1
  vpc_zone_identifier = data.aws_subnets.public.ids

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }

  lifecycle {
    ignore_changes = [
      load_balancers,
      target_group_arns,
    ]
  }

  tag {
    key                 = "Name"
    value               = "${local.project_prefix}-instance"
    propagate_at_launch = true
  }
  tag {
    key                 = "Terraform"
    value               = "true"
    propagate_at_launch = true
  }
  tag {
    key                 = "Project"
    value               = local.project_prefix
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  lb_target_group_arn    = aws_lb_target_group.target_group.arn
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = "${local.project_prefix}-instance-logs-SUFIJO-UNICO"

  tags = local.tags
}