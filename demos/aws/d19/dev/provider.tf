provider "aws" {
  region = var.AWS_REGION
  /*
  https://registry.terraform.io/providers/hashicorp/aws/latest/docs#shared-credentials-file
  profile = "..."
  */
}
