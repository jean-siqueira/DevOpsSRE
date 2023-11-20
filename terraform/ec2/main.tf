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
  region = "us-east-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "devops-sre_security" {
  name        = "devops-sre_security-group"
  description = "Allow TLS inbound traffic"
  # Publica ? comente a linha abaixo.
  #vpc_id = aws_vpc.devops-sre_vpc.id
  
  tags = {
    Name = "devops-sre terraform example"
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

  ingress {
    from_port   = 2375
    to_port     = 2375
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    self             = false
    protocol    = "tcp"
    ipv6_cidr_blocks = []
    prefix_list_ids  = []    
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress     {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
}
resource "aws_vpc" "devops-sre_vpc" {
  cidr_block = "172.31.0.0/16"
  
}
resource "aws_subnet" "devops-sre_subnet" {
  vpc_id                  = aws_vpc.devops-sre_vpc.id
  cidr_block              = "172.31.32.0/20"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_key_pair" "devops-sre_key_pair" {
  key_name   = "devops-sre_key_pair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCv0smyBOrrxeEuVAxmeGWnXSyAgDC7FeAatb28LhyghRfkouQpZ2dCVKKOq5aCNmzIh+zVwKKI+b/G/YFqv4Wbc7rGdtIUKuMcp1Jby5JMf6irBBY8t3gwRGvdVE41va40hyjmE7AVcCQbII4w0uXTjTPnw4BvDHkgfcnm7r77i/u5RnwNscn5te/is81asJ4bTjQfNkK5yMURzab0OZcst3BLieDluyA44h+Vr13CdJdsqPjasECwmp6WxHfF7GDKJ8cVMsxMby3HgZK+KicL3rGepcFC51Okmwr6tRLbQ0myI0zUTJDlQqFj9VRPmfu03oqm+1F3cp5bcWnhdext jean@localhost.localdomain"
}

resource "aws_instance" "devops-sre" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.small"
#  key_name = "terraform"
  key_name = "devops-sre_key_pair"
  vpc_security_group_ids = [aws_security_group.devops-sre_security.id]

  # Publica ? comente a linha abaixo.
  #subnet_id = aws_subnet.devops-sre_subnet.id
 
    connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = file("/run/media/jean/806bddf9-c349-4840-9337-8d26125fb1e6/development/study/devops-sre/cursos/coffeeandit/repo/personal/DevOpsSRE/terraform/ec2")
      host = self.public_ip
  }

  root_block_device {
    volume_size  = "20"
    volume_type = "standard"
    delete_on_termination = true

  }

  tags = {
    Name = "vm-ubuntu-devops-sre-2",
    Env = "Production"
  }
}