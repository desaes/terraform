variable "user_names" {
  description = "Create IAM users with these names"
  type        = list(string)
  default     = ["neo", "trinity", "morpheus"]
}

variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
