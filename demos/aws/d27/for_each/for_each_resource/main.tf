terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

// resource "aws_iam_user" "example" {
//   count = length(var.user_names)
//   name  = var.user_names[count.index]
// }

resource "aws_iam_user" "example" {
  for_each = toset(var.user_names)
  name     = each.value
}