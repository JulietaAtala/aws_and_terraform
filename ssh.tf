
resource "aws_key_pair" "cmtr_keypair" {
  key_name   = "${local.name_for}-keypair"
  public_key = var.ssh_key

  tags = local.tags
}