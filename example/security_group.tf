resource "aws_security_group" "ecs_app" {
  name        = "${local.environment}-app-ecs"
  description = "Allow app hosts to communicate"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${module.vpc.vpc_cidr_block}"]
  }

  tags = merge(
    local.tags,
    map(
      "Name", "${local.environment}-app-ecs"
    )
  )
}
