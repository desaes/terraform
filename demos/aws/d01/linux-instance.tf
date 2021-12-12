resource "aws_key_pair" "terraform" {
  key_name   = "terraform-key"
  public_key = file("${var.PATH_TO_PUBLIC_KEY}")
}

resource "aws_instance" "example" {
  // ami = "${var.AMIS[var.AWS_REGION]}"
  // or
  ami                    = lookup(var.AMIS, var.AWS_REGION)
  instance_type          = var.INSTANCE_TYPE
  key_name               = aws_key_pair.terraform.key_name
  vpc_security_group_ids = ["${aws_security_group.sgAllowRemoteSsh.id}"]
  tags = {
    Name = "example"
  }
  /*
	connection {
		type = "ssh"
		user = "${var.INSTANCE_USERNAME}"
		private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
		host = self.public_ip
	}		
	*/

}

resource "null_resource" "setup" {
  connection {
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file("${var.PATH_TO_PRIVATE_KEY}")
    host        = aws_instance.example.public_ip
  }

  provisioner "file" {
    source      = "app/app.conf"
    destination = "/tmp/app.conf"
  }

  provisioner "file" {
    source      = "app/script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/app.conf /etc/app.conf",
      "sudo mv /tmp/script.sh /usr/local/bin/script.sh",
      "chmod 755 /usr/local/bin/script.sh",
      "/usr/local/bin/script.sh"
    ]
  }

  depends_on = [
    aws_instance.example
  ]
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
