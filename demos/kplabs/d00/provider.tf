// Any version in the 3.x range
terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0" 
        }
    }
}

provider "aws" {
    region = "us-east-1"
}