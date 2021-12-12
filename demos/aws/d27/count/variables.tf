variable "user_names" {
  description = "Create IAM users with these names"
  type        = list(string)
  default     = ["neo", "trinity", "morpheus"]
}

// variable "give_neo_cloudwatch_full_access" {
//   description = "If true, neo gets full access to CloudWatch"
//   type        = bool
// }

variable "policy_name_prefix" {
  description = "The prefix to use for the IAM policy names"
  type        = string
  default     = ""
}

variable "hero_thousand_faces" {
  description = "map"
  type        = map(string)
  default = {
    neo      = "hero"
    trinity  = "love interest"
    morpheus = "mentor"
  }
}

variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
