output "ecr_repos" {
  value = module.ecr.repo_urls
}

output "s3_bucket" {
  value = module.s3.bucket_name
}

output "sqs_queue_url" {
  value = module.sqs.queue_url
}
