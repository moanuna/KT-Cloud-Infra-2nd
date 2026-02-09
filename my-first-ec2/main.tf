# terraform 버전 및 Provider 설정
terraform {
  required_version = ">=1.0.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>4.0"
    }
  }
}

# AWS Provider 설정
provider "aws" {
  region = "ap-northeast-2"

  # 기본 태그	
  default_tags {
    tags = {
      ManagedBy = "Terraform"
      Course = "Terraform-3Day"
      Environment = "Training"
    }
  }
}

# 보안 그룹 생성 
resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh_training"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH from anywhere"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  egress {
    description = "Allow all outbound"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks =["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_training"
  }
}

# EC2 인스턴스 생성
resource "aws_instance" "training_instance" {
  ami = var.ami_id
  instance_type = var.instance_type
  
  # 네트워크 설정 
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  # 키 페어 설정 (있으면 사용)
  key_name = var.key_name
  # 인스턴스 태그 
  tags = {
    Name = var.instance_name
    Type = "Training"
  }
  # 루트 볼륨 설정 
  root_block_device {
    volume_size = 20
    volume_type = "gp3"
    delete_on_termination = true
  }

  # 연결 시 사용자 데이터
  user_data = <<-EOF
 	#!/bin/bash
	echo "Hello from Terraform Training!" > /tmp/hello.txt
	EOF
}

# Elastic IP 할당
resource "aws_eip" "training_eip" {
  instance = aws_instance.training_instance.id
  
  tags = {
    Name= "${var.instance_name}-eip"
  }
}  
