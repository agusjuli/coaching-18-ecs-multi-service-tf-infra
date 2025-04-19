output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "service1_name" {
  value = aws_ecs_service.svc_1.name
}

output "service2_name" {
  value = aws_ecs_service.svc_2.name
}
