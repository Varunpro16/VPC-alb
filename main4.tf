# Create Application Load Balancer
resource "aws_lb" "application_lb" {
  name               = "my-application-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_sg.id]
  subnets            = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]

  tags = {
    Name = "my-application-lb"
  }
}

# Create Target Group for Load Balancer
resource "aws_lb_target_group" "my_target_group" {
  name     = "my-target-group"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "my-target-group"
  }
}

# Attach EC2 Instance to Target Group
resource "aws_lb_target_group_attachment" "tg_attachment_a" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = aws_instance.web_server_a.id
  port             = 5000
}
resource "aws_lb_target_group_attachment" "tg_attachment_b" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = aws_instance.web_server_b.id
  port             = 5000
}

# Create Listener for Load Balancer
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.application_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"

    target_group_arn = aws_lb_target_group.my_target_group.arn

  }	
}

