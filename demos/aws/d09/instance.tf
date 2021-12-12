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
  user_data              = data.template_cloudinit_config.cloudinit-example.rendered
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
  device_name = var.INSTANCE_DEVICE_NAME
  volume_id   = aws_ebs_volume.ebs-volume-1.id
  instance_id = aws_instance.example.id
  // super important, or destroy will not work
  stop_instance_before_detaching = true
  force_detach                   = true
}

output "public_ip_example" {
  value = aws_instance.example.public_ip
}

output "private_ip_example" {
  value = aws_instance.example.private_ip
}
