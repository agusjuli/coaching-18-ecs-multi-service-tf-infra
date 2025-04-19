// modules/ecr/main.tf
resource "aws_ecr_repository" "service_1" {
  name = "service-1-repo"
}

resource "aws_ecr_repository" "service_2" {
  name = "service-2-repo"
}

output "repo_urls" {
  value = {
    service_1 = aws_ecr_repository.service_1.repository_url
    service_2 = aws_ecr_repository.service_2.repository_url
  }
}
