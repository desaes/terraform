/*
terraform {
    backend "consul" {
        address = "demo.consul.io"
        path = "terraform/desaes"
    }
}
*/


// S3
// must do aws configure and create the bucket in s3 (enable versioning) before using it
terraform {
  backend "s3" {
    # Refer to d13
    bucket = "mybucket-desaes"

    ######################## !!!!!!!!!!!!!!!!!!! KEY value must be unique for each project! !!!!!!!!!!!!!!!!!!! ########################
    key    = "terraform/myproject"
    region = "us-east-1"

    # Replace this with your DynamoDB table name! 
    # terraform-locks
    # Refer to d13
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

/*
// read-only remote state (datasource)
data "terraform_remote_state" "aws-state" {
    backend = "s3"
    config {
        bucket = "terraform-state"
        key = "terraform.tfstate"
        access_key = "${var.AWS_ACCESS_KEY}"
        secret_key = "${var.AWS_SECRET_KEY}"
        region = "${var.AWS_REGION}"
    }
}
*/