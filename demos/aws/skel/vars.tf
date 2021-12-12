variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" { default = "us-east-1" }
variable "INSTANCE_TYPE" { default = "t2.micro" }
variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-083654bd07b5da81d"
    us-west-1 = "ami-0a3dfa47e8be"
  }
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "ssh-key"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "ssh-key.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}