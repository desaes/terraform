resource "aws_key_pair" "terraform" {
  key_name   = "terraform-key"
  public_key = file("${var.PATH_TO_PUBLIC_KEY}")
}


resource "aws_instance" "example01" {
  // ami = "${var.AMIS[var.AWS_REGION]}"
  // or
  ami                    = lookup(var.AMIS, var.AWS_REGION)
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.main-public-1.id
  vpc_security_group_ids = ["${aws_security_group.sgAllowRemoteSsh.id}", "${aws_security_group.sgAllowICMP.id}"]
  key_name               = aws_key_pair.terraform.key_name
}

resource "aws_instance" "example02" {
  // ami = "${var.AMIS[var.AWS_REGION]}"
  // or
  ami                    = lookup(var.AMIS, var.AWS_REGION)
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.main-private-1.id
  vpc_security_group_ids = ["${aws_security_group.sgAllowRemoteSsh.id}", "${aws_security_group.sgAllowICMP.id}"]
  key_name               = aws_key_pair.terraform.key_name
}

resource "aws_security_group" "sgAllowRemoteSsh" {
  vpc_id      = aws_vpc.main.id
  name        = "sgAllowRemoteSsh"
  description = "Allow ssh inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sgAllowICMP" {
  vpc_id      = aws_vpc.main.id
  name        = "sgAllowICMP"
  description = "Allow ICMP traffic"

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip_example01" {
  value = aws_instance.example01.public_ip
}

output "private_ip_example01" {
  value = aws_instance.example01.private_ip
}

output "public_ip_example02" {
  value = aws_instance.example02.public_ip
}

output "private_ip_example02" {
  value = aws_instance.example02.private_ip
}