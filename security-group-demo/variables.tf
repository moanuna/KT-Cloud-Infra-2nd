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
