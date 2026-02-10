# 프로젝트 기본 변수
variable "project_name" {
  type = string
  description = "프로젝트 이름"
  default = "terraform-training"
}

variable "environment" {
  type = string
  description = "배포 환경"
  default = "dev"
}

# EC2 인스턴스 변수
variable "instance_count" {
  type = number
  description = "생성할 인스턴스 수"
  default = 1
  validation {
    condition = var.instance_count >= 1 && var.instance_count <= 5
    error_message = "인스턴스 수는 1~5개 사이여야 합니다."
  }
}

variable "instance_type" {
  type = string
  description = "EC2 인스턴스 타입"
  default = "t2.micro"
}

variable "ami_id" {
  type = string
  description = "Ubuntu 22.04 AMI ID (서울 리전)"
  default = "ami-0c9c942bd7bf113a2"
}

variable "env_configs" {
  description = "환경별 EC2 설정"
  type = map(object({
    instance_type = string
    node_count    = number
  }))

  default = {
    dev = {
      instance_type = "t2.micro"
      node_count    = 1
    }
    staging = {
      instance_type = "t3.small"
      node_count    = 2
    }
    prod = {
      instance_type = "t3.large"
      node_count    = 3
    }
  }
}
