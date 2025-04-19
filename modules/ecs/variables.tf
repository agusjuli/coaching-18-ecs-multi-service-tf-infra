variable "ecr_repos" {
  type = map(string)
}

variable "s3_bucket" {
  type = string
}

variable "sqs_url" {
  type = string
}
