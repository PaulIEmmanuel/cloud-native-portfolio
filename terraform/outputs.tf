output "ec2_public_ip" {
  description = "Public IP of the EC2 backend instance"
  value       = aws_instance.portfolio_ec2.public_ip
}

output "ecr_repository_url" {
  description = "ECR repository URL for backend Docker images"
  value       = aws_ecr_repository.portfolio_backend.repository_url
}

output "github_actions_role_arn" {
  description = "IAM role assumed by GitHub Actions for ECR access"
  value       = aws_iam_role.github_actions_role.arn
}
