variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" { default = "us-east-1" }
variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-0a3dfa47e8be93466"
    us-west-1 = "ami-0a3dfa47e8be"
  }
}