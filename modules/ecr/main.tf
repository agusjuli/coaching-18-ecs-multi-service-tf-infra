// modules/ecr/main.tf
resource "aws_ecr_repository" "service_1" {
  name = "service-1-repo"
}

resource "aws_ecr_repository" "service_2" {
  name = "service-2-repo"
}


