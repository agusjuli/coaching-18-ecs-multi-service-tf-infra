# coaching-18-ecs-multi-service-tf-infra
# 📦 Infra Terraform

Infrastructure as Code for ECS microservices stack.

---

## 🏗️ Components
- ECS Cluster with 2 services
- 2 ECR Repositories
- S3 Bucket
- SQS Queue
- IAM Roles and Policies

---

## 📁 Structure
```bash
infra-terraform/
├── main.tf
├── variables.tf
├── outputs.tf
├── modules/
│   ├── ecs/
│   ├── ecr/
│   ├── s3/
│   └── sqs/
└── .github/
    └── workflows/
        └── terraform-deploy.yml 
```

---

## 🚀 Usage
### 1. Initialize and apply
```bash
terraform init
terraform apply
```

### 2. Outputs to note
After applying, note these outputs:
- `ecr_repos.service_1`
- `ecr_repos.service_2`
- `s3_bucket`
- `sqs_queue_url`

Use these in your app repo secrets!

---

## 🔐 IAM Requirements
This should be run using a user or role that has permissions for:
- ECS
- ECR
- S3
- SQS
- IAM

---

## 🧪 GitHub Action
Add `terraform-deploy.yml` in workflows to automate deployment from GitHub.

