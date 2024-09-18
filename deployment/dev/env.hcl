locals {
  aws_account_id = "008971679247"
  environment    = "dev"
}

inputs = {
  environment    = local.environment
  aws_account_id = local.aws_account_id
}
