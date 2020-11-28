data "aws_ssm_parameter" "aws_ecs_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

data "aws_region" "current" {}

data "template_file" "ecs_user_data" {
  template = file("${path.module}/data/ecs-user-data.tpl")

  vars = {
    ecs_cluster        = aws_ecs_cluster.application.name
    region             = data.aws_region.current.name
    efs_security_group = var.efs_security_group
  }
}
