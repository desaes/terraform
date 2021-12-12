variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" { default = "us-east-1" }
variable "INSTANCE_TYPE" { default = "t2.micro" }

variable "WIN_AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-06298518240efec41"
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "ssh-key"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "ssh-key.pub"
}

variable "INSTANCE_USERNAME" {
  default = "terraform"
}

variable "INSTANCE_PASSWORD" {}