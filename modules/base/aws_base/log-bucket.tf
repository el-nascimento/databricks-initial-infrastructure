module "log-bucket" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  version       = "4.1.2"
  bucket        = "${local.prefix}-log-storage"
  tags          = var.tags
  force_destroy = true
  versioning = {
    enabled = false
  }
}
