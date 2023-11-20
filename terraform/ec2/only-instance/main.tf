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
  region = "us-east-2"
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



resource "aws_instance" "coffeeandit" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.small"
#  key_name = "terraform"
  key_name = "coffeeandit_key_pair"
  vpc_security_group_ids = [var.security-group-id]
 
    connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = file("~/Coffeeandit/Projetos/FullStack/aws/terraform/ec2/id_rsa")
      host = self.public_ip
  }

  root_block_device {
    volume_size  = "20"
    volume_type = "standard"
    delete_on_termination = true

  }

  tags = {
    Name = "vm-ubuntu-coffeeandit-2",
    Env = "Production"
  }
}
