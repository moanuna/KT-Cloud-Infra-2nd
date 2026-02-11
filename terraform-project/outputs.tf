output "instance_ids" {
  value       = aws_instance.web_server[*].id
  description = "생성된 모든 EC2 인스턴스의 ID"
}

output "public_ips" {
  value       = aws_instance.web_server[*].public_ip
  description = "EC2 인스턴스들의 공인 IP 주소들"
}

output "ssh_commands" {
  value = [
    for instance in aws_instance.web_server :
    "ssh -i \"~/.ssh/${var.key_name}.pem\" ubuntu@${instance.public_ip} # ${instance.tags.Name}"
  ]
  description = "각 인스턴스별 SSH 접속 명령어"
}

output "web_urls" {
  value = [
    for instance in aws_instance.web_server :
    "http://${instance.public_ip}"
  ]
  description = "웹 서버 접속 URL 목록"
}

output "security_group_id" {
  value       = aws_security_group.web.id
  description = "웹 서버 보안 그룹 ID"
}

output "infrastructure_summary" {
  value = {
    instance_count  = length(aws_instance.web_server)
    security_groups = 3
    region          = var.aws_region
    environment     = var.environment
    deployed_at     = timestamp()
  }
  description = "인프라 구성 요약 정보"
}
