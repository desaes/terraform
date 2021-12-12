resource "aws_key_pair" "terraform" {
  key_name   = "terraform_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "win-example" {
  ami                    = data.aws_ami.windows-ami.image_id
  instance_type          = var.INSTANCE_TYPE
  key_name               = aws_key_pair.terraform.key_name
  vpc_security_group_ids = ["${aws_security_group.sgAllowWinRM.id}", "${aws_security_group.sgAllowRDP.id}"]
  tags = {
    Name = "win-example"
  }
  user_data = <<EOF
<powershell>
net user ${var.INSTANCE_USERNAME} '${var.INSTANCE_PASSWORD}' /add /y
net localgroup administrators ${var.INSTANCE_USERNAME} /add

winrm quickconfig -q
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="300"}'
winrm set winrm/config '@{MaxTimeoutms="1800000"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'

netsh advfirewall firewall add rule name="WinRM 5985" protocol=TCP dir=in localport=5985 action=allow
netsh advfirewall firewall add rule name="WinRM 5986" protocol=TCP dir=in localport=5986 action=allow

net stop winrm
sc.exe config winrm start=auto
net start winrm
</powershell>
EOF
}

resource "null_resource" "setup" {
  connection {
    host     = aws_instance.win-example.public_ip
    type     = "winrm"
    timeout  = "10m"
    user     = var.INSTANCE_USERNAME
    password = var.INSTANCE_PASSWORD
  }

  provisioner "file" {
    source      = "app/app.conf"
    destination = "c:/app.conf"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.win-example.private_ip} >> c:/temp/private_ips.txt"
  }

  depends_on = [
    aws_instance.win-example
  ]
}

resource "aws_security_group" "sgAllowWinRM" {
  name        = "sgAllowWinRM"
  description = "Allow WinRM inbound traffic"

  ingress {
    from_port   = 5985
    to_port     = 5986
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

resource "aws_security_group" "sgAllowRDP" {
  name        = "sgAllowRDP"
  description = "Allow RDP inbound traffic"

  ingress {
    from_port   = 3389
    to_port     = 3389
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

output "public_ip" {
  value = aws_instance.win-example.public_ip
}

output "private_ip" {
  value = aws_instance.win-example.private_ip
}