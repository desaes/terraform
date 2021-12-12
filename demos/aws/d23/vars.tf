variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" { default = "us-east-1" }
variable "INSTANCE_TYPE" { default = "t2.micro" }
variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-0a3dfa47e8be93466"
    us-west-1 = "ami-0a3dfa47e8be"
  }
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "ssh-key"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "ssh-key.pub"
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

variable "alb_name" {
  description = "The name of the ALB"
  type        = string
  default     = "terraform-asg-example"
}

variable "instance_security_group_name" {
  description = "The name of the security group for the EC2 Instances"
  type        = string
  default     = "terraform-example-instance"
}

variable "alb_security_group_name" {
  description = "The name of the security group for the ALB"
  type        = string
  default     = "terraform-example-alb"
}