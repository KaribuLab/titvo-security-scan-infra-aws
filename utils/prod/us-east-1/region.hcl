locals {
  name = get_env("AWS_REGION", basename(get_terragrunt_dir()))
}