resource "aws_iam_group" "iam_group" {
  name = "${var.project_id}-iam-group"
}

resource "aws_iam_policy" "cmtr-m68g13qx-iam-policy" {
  name        = "${var.project_id}-iam-policy"
  description = "My example policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ]
        Resource = "arn:aws:s3:::${var.project_id}-bucket-1759147576"
      }
    ]
  })

  tags = {
    Project   = var.project_name_prefix
    Terraform = "true"
  }
}

resource "aws_iam_role" "iam_role" {
  name = "${var.project_id}-iam-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
  tags = {
    Project   = var.project_name_prefix
    Terraform = "true"
  }
}

resource "aws_iam_role_policy_attachment" "role_attach" {
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.cmtr-m68g13qx-iam-policy.arn
}

resource "aws_iam_instance_profile" "my_instance_profile" {
  name = "${var.project_id}-iam-instance-profile"
  role = aws_iam_role.iam_role.name
}