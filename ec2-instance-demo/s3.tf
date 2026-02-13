resource "aws_s3_bucket" "data" {
  bucket = "my-unique-bucket-name-2026-seungyeon"

  tags = {
    Name = "DataBucket"
    Environment = "Dev"
  }
}

# 버킷 버전 관리 활성화
resource "aws_s3_bucket_versioning" "data_versioning" {
  bucket = var.bucket_name

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "data_block" {
  bucket = aws_s3_bucket.data.id

  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}
