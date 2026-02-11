variable "os_type" {
  description = "운영체제 타입"
  type        = string
  default     = "ubuntu"

  validation {
    condition     = contains(["ubuntu", "amazon_linux", "windows"], var.os_type)
    error_message = "OS 타입은 ubuntu, amazon_linux, windows 중 하나여야 합니다."
  }
}

# 지역 변수로 AMI 필터 정의
locals {
  ami_filters = {
    ubuntu = [
      {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
      },
      {
        name   = "virtualization-type"
        values = ["hvm"]
      }
    ]
    amazon_linux = [
      {
        name   = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
      }
    ]
    windows = [
      {
        name   = "name"
        values = ["Windows_Server-2019-English-Full-Base-*"]
      }
    ]
  }

  ami_owners = {
    ubuntu       = ["099720109477"]
    amazon_linux = ["amazon"]
    windows      = ["amazon"]
  }
}

# 데이터 소스 구성
data "aws_ami" "selected_os" {
  most_recent = true

  dynamic "filter" {
    for_each = local.ami_filters[var.os_type]
    content {
      name   = filter.value.name
      values = filter.value.values
    }
  }

  owners = local.ami_owners[var.os_type]
}

resource "aws_instance" "server" {
  ami           = data.aws_ami.selected_os.id
  instance_type = "t3.micro"

  tags = {
    Name     = "terraform-datasource"
    OS       = var.os_type
    AMI_Name = data.aws_ami.selected_os.name
  }
}
