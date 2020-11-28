data "aws_availability_zones" "available" {}

locals {
  vpc_cidr = "10.50.0.0/16"
}
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.33.0"

  name = "${local.environment}-vpc"
  cidr = local.vpc_cidr

  enable_s3_endpoint = true

  azs = [
    data.aws_availability_zones.available.names[0],
    data.aws_availability_zones.available.names[1],
    data.aws_availability_zones.available.names[2],
  ]

  private_subnets = [
    cidrsubnet(local.vpc_cidr, 7, 0),
    cidrsubnet(local.vpc_cidr, 7, 1),
    cidrsubnet(local.vpc_cidr, 7, 2),
  ]

  public_subnets = [
    cidrsubnet(local.vpc_cidr, 7, 50),
    cidrsubnet(local.vpc_cidr, 7, 51),
    cidrsubnet(local.vpc_cidr, 7, 52),
  ]

  enable_nat_gateway     = false
  single_nat_gateway     = false
  one_nat_gateway_per_az = true
  enable_vpn_gateway     = false
  enable_dns_hostnames   = true
  enable_dns_support     = true

  public_subnet_tags = {
    "subnet_type" = "public"
  }

  private_subnet_tags = {
    "subnet_type" = "private"
  }
}
