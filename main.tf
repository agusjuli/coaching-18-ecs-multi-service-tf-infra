// Root-level main.tf
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name = "default-vpc"
  use_default_vpc = true
}

module "ecr" {
  source = "./modules/ecr"
}

module "s3" {
  source = "./modules/s3"
}

module "sqs" {
  source = "./modules/sqs"
}

module "ecs" {
  source = "./modules/ecs"
  ecr_repos = module.ecr.repo_urls
  s3_bucket = module.s3.bucket_name
  sqs_url   = module.sqs.queue_url
}