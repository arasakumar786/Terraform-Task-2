terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Providers
provider "aws" {
  alias  = "ap_south_1"
  region = var.region_ap_south_1
}

provider "aws" {
  alias  = "ap_south_2"
  region = var.region_ap_south_2
}

# Security Groups
resource "aws_security_group" "nginx_sg_ap_south_1" {
  provider    = aws.ap_south_1
  name        = "nginx-sg-ap-south-1"
  description = "Allow HTTP inbound traffic"
  
  ingress {
    from_port   = 80
    to_port     = 80
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

resource "aws_security_group" "nginx_sg_ap_south_2" {
  provider    = aws.ap_south_2
  name        = "nginx-sg-ap-south-2"
  description = "Allow HTTP inbound traffic"
  
  ingress {
    from_port   = 80
    to_port     = 80
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

# EC2 Instances
resource "aws_instance" "web_ap_south_1" {
  provider        = aws.ap_south_1
  ami             = var.ami_ap_south_1
  instance_type   = var.instance_type
  security_groups = [aws_security_group.nginx_sg_ap_south_1.name]
  key_name        = var.key_ap_south_1

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install nginx -y
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  tags = {
    Name = "nginx-ap-south-1"
  }
}

resource "aws_instance" "web_ap_south_2" {
  provider        = aws.ap_south_2
  ami             = var.ami_ap_south_2
  instance_type   = var.instance_type
  security_groups = [aws_security_group.nginx_sg_ap_south_2.name]
  key_name        = var.key_ap_south_2

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install nginx -y
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  tags = {
    Name = "nginx-ap-south-2"
  }
}
