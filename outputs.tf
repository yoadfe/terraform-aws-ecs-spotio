output "cluster_id" {
  value       = aws_ecs_cluster.application.id
  description = "The aws id of the cluster"
}

output "cluster_name" {
  value       = aws_ecs_cluster.application.name
  description = "The name of the cluster"
}
