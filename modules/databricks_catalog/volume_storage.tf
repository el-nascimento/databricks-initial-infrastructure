// Raw bucket volume
module "raw_bucket" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  version       = "4.1.2"
  bucket        = local.raw_bucket
  force_destroy = true
  versioning = {
    status = "Disabled"
  }
}

# resource "aws_s3_bucket_public_access_block" "raw_bucket" {
#   bucket                  = module.raw_bucket.s3_bucket_id
#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
#   depends_on              = [module.raw_bucket]
# }

data "aws_iam_policy_document" "passrole_for_external_raw_bucket" {
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

resource "aws_iam_policy" "external_raw_bucket" {
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "${module.raw_bucket.s3_bucket_id}-policy"
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
          module.raw_bucket.s3_bucket_arn,
          "${module.raw_bucket.s3_bucket_arn}/*"
        ],
        "Effect" : "Allow"
      }
    ]
  })
}


resource "aws_iam_role" "raw_data_access" {
  name                = "${module.raw_bucket.s3_bucket_id}-access"
  assume_role_policy  = data.aws_iam_policy_document.passrole_for_external_raw_bucket.json
  managed_policy_arns = [aws_iam_policy.external_raw_bucket.arn]
}

// Sandbox bucket volume
module "sandbox_bucket" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  version       = "4.1.2"
  bucket        = local.sandbox_bucket
  force_destroy = true
  versioning = {
    status = "Disabled"
  }
}

# resource "aws_s3_bucket_public_access_block" "sandbox_bucket" {
#   bucket                  = module.sandbox_bucket.s3_bucket_id
#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
#   depends_on              = [module.sandbox_bucket]
# }

data "aws_iam_policy_document" "passrole_for_external_sandbox_bucket" {
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

resource "aws_iam_policy" "external_sandbox_bucket" {
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "${module.sandbox_bucket.s3_bucket_id}-policy"
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
          module.sandbox_bucket.s3_bucket_arn,
          "${module.sandbox_bucket.s3_bucket_arn}/*"
        ],
        "Effect" : "Allow"
      }
    ]
  })
}


resource "aws_iam_role" "sandbox_data_access" {
  name                = "${module.sandbox_bucket.s3_bucket_id}-access"
  assume_role_policy  = data.aws_iam_policy_document.passrole_for_external_sandbox_bucket.json
  managed_policy_arns = [aws_iam_policy.external_sandbox_bucket.arn]
}
