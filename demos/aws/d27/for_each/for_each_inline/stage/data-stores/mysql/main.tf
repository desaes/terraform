terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      version = "~> 2.0"
    }
  }
  backend "s3" {

    # This backend configuration is filled in automatically at test time by Terratest. If you wish to run this example
    # manually, uncomment and fill in the config below.

    bucket         = "desaes-terraform-state-bucket"
    key            = "terraform/stage-terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "desaes-terraform-lock-table"
    encrypt        = true

  }

}

provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-lab"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  username            = "admin"
  name                = var.db_name
  skip_final_snapshot = true
  password            = var.db_password
}