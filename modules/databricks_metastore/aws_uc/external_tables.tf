resource "aws_s3_bucket" "external" {
  bucket = "${local.prefix}-external"
  force_destroy = true
  tags = var.tags
}

resource "aws_s3_bucket_versioning" "external" {
  bucket = aws_s3_bucket.external.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_public_access_block" "external" {
  bucket             = aws_s3_bucket.external.id
  ignore_public_acls = true
  depends_on         = [aws_s3_bucket.external]
}

resource "aws_iam_policy" "external_data_access" {
  // Terraform's "jsonencode" function converts a
  // Terraform expression's result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "${aws_s3_bucket.external.id}-access"
    Statement = [
      {
        "Action" : [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:DeleteObject",
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ],
        "Resource" : [
          aws_s3_bucket.external.arn,
          "${aws_s3_bucket.external.arn}/*"
        ],
        "Effect" : "Allow"
      }
    ]
  })
  tags = var.tags
}

resource "aws_iam_role" "external_data_access" {
  name                = "${local.prefix}-external-access"
  assume_role_policy  = data.aws_iam_policy_document.passrole_for_uc.json
  managed_policy_arns = [aws_iam_policy.external_data_access.arn]
  tags = var.tags
}
