resource "aws_ecs_cluster" "application" {
  name = var.cluster_name

  tags = merge(
    var.tags,
    {
      "Name" = var.cluster_name
    },
  )
}
