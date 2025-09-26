
locals {
  name_for = var.project_name_prefix
  tags = {
    Terraform = "true"
    Owner     = var.project_name_prefix
    Project   = var.project_name_prefix
    ID        = var.project_name_prefix
  }
}