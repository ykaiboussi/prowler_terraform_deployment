output "url" {
  value = aws_ecr_repository.this.repository_url
  description = "The url of image repository"
}