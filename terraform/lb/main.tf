terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region = var.region
}

resource "aws_security_group" "devops-sre_security_lb" {
  name        = "devops-sre_security_lb"
  description = "Allow TLS inbound traffic"
  vpc_id = var.vpc_id
  
  tags = {
    Name = "devops-sre Security Group"
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "devops-sre_lb" {
  name = "devops-sre-lb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.devops-sre_security_lb.id]
  subnets = [var.subnets[0], var.subnets[1]]

  tags = {
    "loadbalancer" = "PRD"
  }

}

resource "aws_lb_target_group" "devops-sre_target_group" {
  name     = "devops-sre-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "tg_attachment_test" {
  
    target_id        = var.instance_id
    port             = 80
    target_group_arn = aws_lb_target_group.devops-sre_target_group.arn
}

resource "aws_lb_listener" "front_end" {

  load_balancer_arn = aws_lb.devops-sre_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.devops-sre_target_group.arn
  }
}
