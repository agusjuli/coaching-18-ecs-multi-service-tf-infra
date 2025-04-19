// modules/sqs/main.tf
resource "aws_sqs_queue" "app_queue" {
  name = "ecs-service-message-queue"
}

output "queue_url" {
  value = aws_sqs_queue.app_queue.id
}