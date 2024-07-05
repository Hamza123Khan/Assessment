resource "aws_key_pair" "Assessment-key" {
  key_name   = "assessment"
  public_key = file("assessment.pub")
}

resource "aws_instance" "web_instance" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.small"
  subnet_id              = aws_subnet.public-1a.id
  availability_zone      = var.ZONE1
  key_name               = aws_key_pair.Assessment-key.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name    = "infrastructure"
    Project = "Assessment"
  }
}

resource "aws_lb" "elb" {
  name               = "elb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb_sg.id]
  subnets            = [aws_subnet.public-1a.id, aws_subnet.public-1b.id]
}

resource "aws_lb_target_group" "targetgrp" {
  name     = "targetgrp"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.elb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.targetgrp.arn
  }
}

resource "aws_lb_target_group_attachment" "web_lb_attachment" {
  target_group_arn = aws_lb_target_group.targetgrp.arn
  target_id        = aws_instance.web_instance.id
  port             = 80
}

output "Public_IP" {
  value = aws_instance.web_instance.public_ip
}

output "Private_IP" {
  value = aws_instance.web_instance.private_ip
}
