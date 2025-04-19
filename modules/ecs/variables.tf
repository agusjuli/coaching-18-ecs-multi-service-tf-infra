variable "ecr_repos" {
  description = "Map of ECR repo URLs for ECS services"
  type        = map(string)
}

variable "s3_bucket" {
  description = "S3 bucket name for file uploads"
  type        = string
}

variable "sqs_url" {
  description = "URL of the SQS queue for messages"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for ECS services"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security group IDs to attach to ECS services"
  type        = list(string)
}
