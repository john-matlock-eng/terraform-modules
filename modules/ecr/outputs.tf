output "repository_url" {
  description = "The URL of the repository"
  value       = aws_ecr_repository.lambda_repo.repository_url
}

output "repository_arn" {
  description = "The ARN of the repository"
  value       = aws_ecr_repository.lambda_repo.arn
}

output "repository_name" {
  description = "The name of the repository"
  value       = aws_ecr_repository.lambda_repo.name
}
