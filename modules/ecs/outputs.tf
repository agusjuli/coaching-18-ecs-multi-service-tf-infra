output "ecs_cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "service1_name" {
  value = aws_ecs_service.service1.name
}

output "service2_name" {
  value = aws_ecs_service.service2.name
}
