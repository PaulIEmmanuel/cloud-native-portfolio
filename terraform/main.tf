data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  owners = ["amazon"]
}

# DynamoDB
resource "aws_dynamodb_table" "portfolio_messages" {
  name         = "PortfolioMessages"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "message_id"

  attribute {
    name = "message_id"
    type = "S"
  }
}

# Security Group
resource "aws_security_group" "portfolio_sg" {
  name        = "portfolio-sg"
  description = "Allow SSH from admin IP and HTTPS from the internet"
    vpc_id      = "vpc-0cd4bec7d3e93cc45"

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
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.admin_ip}/32"]  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "portfolio-sg"
  }

   lifecycle {
    ignore_changes = [
      egress,
      name,
      description,
      tags
    ]
  }
}

# EC2
resource "aws_instance" "portfolio_ec2" {
  ami                    = data.aws_ami.amazon_linux.id 
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.portfolio_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "portfolio-backend"
  }

  user_data = <<-EOF
#!/bin/bash
yum update -y

# Install Docker
yum install -y docker
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user

# Install AWS CLI v2 (not always preinstalled)
yum install -y awscli

# Login to ECR
aws ecr get-login-password --region us-east-1 \
| docker login --username AWS --password-stdin ${aws_ecr_repository.portfolio_backend.repository_url}

# Pull image
docker pull ${aws_ecr_repository.portfolio_backend.repository_url}:latest

# Run container
docker stop portfolio-backend || true
docker rm portfolio-backend || true

docker run -d \
  --name portfolio-backend \
  -p 80:5000 \
  ${aws_ecr_repository.portfolio_backend.repository_url}:latest
EOF



  lifecycle {
    ignore_changes = [
      ami,
      iam_instance_profile,
      security_groups,
      vpc_security_group_ids
    ]
  }
} 
