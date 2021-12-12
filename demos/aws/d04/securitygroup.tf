
data "aws_ip_ranges" "us_ec2" {
  regions  = ["us-east-1"]
  services = ["ec2"]
}

variable "max_ingress_rules" {
  default = 60
}

locals {
  chunks     = chunklist(data.aws_ip_ranges.us_ec2.cidr_blocks, var.max_ingress_rules)
  chunks_map = { for i in range(length(local.chunks)) : i => local.chunks[i] }
}

resource "aws_security_group" "from_us" {
  for_each    = local.chunks_map
  name        = "from_us_${each.key}"
  description = "Allow EC2 traffic from us-east-1"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = each.value
  }
  tags = {
    CreateData = "${data.aws_ip_ranges.us_ec2.create_date}"
    SyncToken  = "${data.aws_ip_ranges.us_ec2.sync_token}"
  }
}

output "ranges" {
  value = data.aws_ip_ranges.us_ec2.cidr_blocks
}