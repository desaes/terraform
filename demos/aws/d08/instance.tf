resource "aws_key_pair" "terraform" {
  key_name   = "terraform-key"
  public_key = file("${var.PATH_TO_PUBLIC_KEY}")
}


resource "aws_instance" "example" {
  // ami = "${var.AMIS[var.AWS_REGION]}"
  // or

  root_block_device {
    volume_size           = 16
    volume_type           = "gp2"
    delete_on_termination = true
  }
  ami                    = lookup(var.AMIS, var.AWS_REGION)
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.sgAllowRemoteSsh.id}"]
  key_name               = aws_key_pair.terraform.key_name
  availability_zone      = "us-east-1a"
}

resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "us-east-1a"
  size              = 10
  type              = "gp2"
  tags = {
    Name = "extra volume data"
  }
}

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.ebs-volume-1.id
  instance_id = aws_instance.example.id
}

resource "aws_security_group" "sgAllowRemoteSsh" {
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

output "public_ip_example" {
  value = aws_instance.example.public_ip
}

output "private_ip_example" {
  value = aws_instance.example.private_ip
}
