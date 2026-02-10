# resource "aws_instance" "web" {
#   count = var.instance_count # 변수 사용
#   ami = var.ami_id
#     instance_type = var.instance_type

#   tags = {
#     Name = "${var.project_name}-${var.environment}-${count.index}"
#     Environment = var.environment
#     Project = var.project_name
#   }
# }
locals {
  config = var.env_configs[var.environment]
}

resource "aws_instance" "web" {
  count         = local.config.node_count
  ami           = var.ami_id
  instance_type = local.config.instance_type

  tags = {
    Name        = "${var.project_name}-${var.environment}-${count.index}"
    Environment = var.environment
    Project     = var.project_name
  }
}
