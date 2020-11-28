resource "spotinst_ocean_ecs" "ocean-autoscaling-group" {
  region       = data.aws_region.current.name
  name         = var.cluster_name
  cluster_name = var.cluster_name

  min_size = 0

  subnet_ids = var.instance_subnets

  security_group_ids   = var.security_groups
  image_id             = data.aws_ssm_parameter.aws_ecs_ami.value
  iam_instance_profile = aws_iam_instance_profile.ecs-instance-profile.id

  key_pair  = var.instance_ssh_key
  user_data = data.template_file.ecs_user_data.rendered

  update_policy {
    should_roll = true

    roll_config {
      batch_size_percentage = 100
    }
  }

  tags {
    key   = "Name"
    value = "${aws_ecs_cluster.application.name}-worker"
  }

  tags {
    key   = "Environment"
    value = var.environment
  }

  tags {
    key   = "Application"
    value = "app-${var.environment}"
  }

  tags {
    key   = "Monitoring"
    value = "On"
  }
}
