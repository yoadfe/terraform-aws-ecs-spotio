data "aws_iam_policy_document" "ecs-instance-assume-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::778564143811:root"]
    }
  }
}

resource "aws_iam_policy" "ecs-instace-role-policy" {
  name = "ecs-${var.environment}-instance-role-policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:Describe*",
                "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
                "elasticloadbalancing:DeregisterTargets",
                "elasticloadbalancing:Describe*",
                "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
                "elasticloadbalancing:RegisterTargets",
                "route53:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role" "ecs-instance-role" {
  name               = "ecs-${var.environment}-instance-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ecs-instance-assume-policy.json

  tags = merge(
    var.tags,
    {
      "Name" = "ecs-${var.environment}-instance-role"
    },
  )
}

resource "aws_iam_role_policy_attachment" "ecs_ec2_role" {
  role       = aws_iam_role.ecs-instance-role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ecs_ec2_cloudwatch_role" {
  role       = aws_iam_role.ecs-instance-role.id
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_iam_role_policy_attachment" "ecs-instance-role-attachment-policy" {
  role       = aws_iam_role.ecs-instance-role.name
  policy_arn = aws_iam_policy.ecs-instace-role-policy.arn
}


resource "aws_iam_instance_profile" "ecs-instance-profile" {
  name = "ecs-${var.environment}-instance-profile"
  path = "/"
  role = aws_iam_role.ecs-instance-role.id

  provisioner "local-exec" {
    command = "sleep 60"
  }
}
