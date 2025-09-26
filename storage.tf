
resource "aws_s3_bucket" "cmtr_bucket" {
  bucket = "cmtr-m68g13qx-bucket-1758901329"

  tags = local.tags
}

resource "aws_s3_bucket_public_access_block" "cmtr_bucket" {
  bucket = aws_s3_bucket.cmtr_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}