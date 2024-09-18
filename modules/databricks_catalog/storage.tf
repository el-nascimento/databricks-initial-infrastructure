module "bucket" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  version       = "4.1.2"
  bucket        = local.catalog_bucket
  force_destroy = true
  versioning = {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_public_access_block" "metastore" {
  bucket                  = module.bucket.s3_bucket_id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  depends_on              = [module.bucket]
}

data "aws_iam_policy_document" "passrole_for_catalog" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = [local.unity_catalog_role_arn]
      type        = "AWS"
    }
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.databricks_account_id]
    }
  }
}

resource "aws_iam_policy" "catalog" {
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "${local.catalog_bucket}-policy"
    Statement = [
      {
        "Action" : [
          "s3:Get*",
          "s3:Put*",
          "s3:List*",
          "s3:DeleteObject"
          # "s3:GetObject",
          # "s3:GetObjectVersion",
          # "s3:PutObject",
          # "s3:PutObjectAcl",
          # "s3:DeleteObject",
          # "s3:ListBucket",
          # "s3:GetBucketLocation"
        ],
        "Resource" : [
          module.bucket.s3_bucket_arn,
          "${module.bucket.s3_bucket_arn}/*"
        ],
        "Effect" : "Allow"
      }
    ]
  })
}


resource "aws_iam_role" "catalog_data_access" {
  name                = "${local.catalog_bucket}-access"
  assume_role_policy  = data.aws_iam_policy_document.passrole_for_catalog.json
  managed_policy_arns = [aws_iam_policy.catalog.arn]
}
