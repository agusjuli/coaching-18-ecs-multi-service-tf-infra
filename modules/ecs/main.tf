// modules/ecs/main.tf
variable "ecr_repos" { type = map(string) }
variable "s3_bucket" { type = string }
variable "sqs_url"   { type = string }

resource "aws_ecs_cluster" "main" {
  name = "ecs-app-cluster"
}

resource "aws_iam_role" "task_exec" {
  name = "ecsTaskExecutionRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = { Service = "ecs-tasks.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_exec" {
  role       = aws_iam_role.task_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_policy" "custom_app_policy" {
  name = "ecs-custom-app-policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["s3:PutObject"],
        Resource = "arn:aws:s3:::${var.s3_bucket}/*"
      },
      {
        Effect   = "Allow",
        Action   = ["sqs:SendMessage"],
        Resource = var.sqs_url
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "app_access" {
  role       = aws_iam_role.task_exec.name
  policy_arn = aws_iam_policy.custom_app_policy.arn
}

resource "aws_ecs_task_definition" "service_1" {
  family                   = "service-1-task"
  network_mode            = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                     = "256"
  memory                  = "512"
  execution_role_arn      = aws_iam_role.task_exec.arn
  container_definitions   = jsonencode([{
    name      = "service-1",
    image     = var.ecr_repos["service_1"]
    essential = true,
    portMappings = [{ containerPort = 5000 }],
    environment = [{ name = "S3_BUCKET_NAME", value = var.s3_bucket }]
  }])
}

resource "aws_ecs_task_definition" "service_2" {
  family                   = "service-2-task"
  network_mode            = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                     = "256"
  memory                  = "512"
  execution_role_arn      = aws_iam_role.task_exec.arn
  container_definitions   = jsonencode([{
    name      = "service-2",
    image     = var.ecr_repos["service_2"]
    essential = true,
    portMappings = [{ containerPort = 5000 }],
    environment = [{ name = "SQS_QUEUE_URL", value = var.sqs_url }]
  }])
}

resource "aws_ecs_service" "svc_1" {
  name            = "service-1"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.service_1.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets         = data.aws_subnets.default.ids
    assign_public_ip = true
  }
}

resource "aws_ecs_service" "svc_2" {
  name            = "service-2"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.service_2.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets         = data.aws_subnets.default.ids
    assign_public_ip = true
  }
}

data "aws_subnets" "default" {
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}

