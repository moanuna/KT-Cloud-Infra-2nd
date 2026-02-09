# 1. variables.tf 파일에 정의
variable "instance_type" {
  description = "EC2 인스턴스 타입"
  type        = string
  default     = "t3.micro"

  # 유효성 검사
  validation {
    condition     = can(regex("^t[23]\\.", var.instance_type))
    error_message = "인스턴스 타입은 t2 또는 t3 계열이어야 합니다."
  }
}
