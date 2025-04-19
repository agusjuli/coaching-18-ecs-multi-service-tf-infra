output "queue_url" {
  value = aws_sqs_queue.app_queue.id
}
