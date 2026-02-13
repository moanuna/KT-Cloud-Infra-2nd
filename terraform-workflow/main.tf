provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "practice" {
  ami = "ami-0c9c942bd7bf113a2"
  instance_type = "t3.small"

  tags = {
    Name = "TerraformPractice"
  }
}

output "instance_id" {
  value = aws_instance.practice.id
}
