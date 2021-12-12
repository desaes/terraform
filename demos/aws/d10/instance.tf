resource "aws_key_pair" "terraform" {
  key_name   = "terraform-key"
  public_key = file("${var.PATH_TO_PUBLIC_KEY}")
}


resource "aws_instance" "example" {
  ami                    = lookup(var.AMIS, var.AWS_REGION)
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.main-public-1.id
  vpc_security_group_ids = ["${aws_security_group.sgAllowRemoteSsh.id}"]
  key_name               = aws_key_pair.terraform.key_name
  availability_zone      = "us-east-1a"
  private_ip             = "10.0.1.4"
}

resource "aws_eip" "example-eip" {
  instance = aws_instance.example.id
  vpc      = true
}

// this is transient, don't use it, use aws_eip.example-eip.public_ip instead
/*
output "public_ip_example" {
    value = "${aws_instance.example.public_ip}"
}
*/

output "public_eip_example" {
  value = aws_eip.example-eip.public_ip
}

output "private_ip_example" {
  value = aws_instance.example.private_ip
}
