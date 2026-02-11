variable "key_name" {
  description = "이미 AWS에 존재하는 EC2 Key Pair 이름"
  type        = string
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
}

variable "project_name" {
  description = "Allow traffic from web to app servers"
  type        = string
  default     = "server-sg"
}

variable "ami_id" {
  description = "EC2에 사용할 AMI ID"
  type        = string
  default     = "ami-0c9c942bd7bf113a2" # Ubuntu 22.04
}

variable "instance_type" {
  description = "EC2 인스턴스 유형"
  type        = string
  default     = "t3.micro"
}
