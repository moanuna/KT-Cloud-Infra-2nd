# 인스턴스 이름 변수
variable "instance_name" {
  description = "EC2 인스턴스 이름"
  type        = string
  default     = "TerrformTrainingInstance"
}

# 인스턴스 타입 변수
variable "instance_type" {
  description = "EC2 인스턴스 타입"
  type        = string
  default     = "t3.micro"

  validation {
    condition     = can(regex("^t[23]\\.", var.instance_type))
    error_message = "인스턴스 타입은 t2 또는 t3 계열이어야 합니다."
  }
}

variable "ami_id" {
  description = "Ubuntu 22.04 LTS AMI ID"
  type        = string
  default     = "ami-0c9c942bd7bf113a2"
}

variable "key_name" {
  description = "기존 EC2 키 페어 이름"
  type        = string
  default     = null
}
