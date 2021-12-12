resource "aws_alb" "my-alb" {
  name            = "my-alb"
  subnets         = ["${aws_subnet.main-public-1.id}", "${aws_subnet.main-public-2.id}"]
  security_groups = ["${aws_security_group.elb-securitygroup.id}"]
  tags = {
    Name = "my-alb"
  }
}

resource "aws_alb_target_group" "frontend-target-group" {
  name     = "alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_alb_target_group_attachment" "frontend-attachment-1" {
  target_group_arn = aws_alb_targetr_group.frontend-target-group.arn
  target_id        = aws_instance.example-instance.id
  port             = 80
}

resource "aws_alb_listener" "frontend-listeners" {
  load_balancer_arn = aws_alb.my-alb.arn
  port              = 80

  default_action {
    target_group_arn = aws_alb_target_group.frontend-target-group.arn
    type             = "forward"
  }
}