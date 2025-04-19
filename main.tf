// Root-level main.tf
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name = "default-vpc"

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

  ecr_repos       = module.ecr.repo_urls
  s3_bucket       = module.s3.bucket_name
  sqs_url         = module.sqs.queue_url
  subnet_ids      = var.subnet_ids
  security_groups = var.security_groups
}
