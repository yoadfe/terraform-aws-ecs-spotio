# AWS Elastic Container Service (ECS) + Spot.io Terraform module

This module will create an ECS cluter with spot.io workers,
the cluster size would be dynamically determined by number of services.


The resources created with this cluster
* [ECS](https://www.terraform.io/docs/providers/aws/r/ecs_cluster.html)
* [IAM](https://www.terraform.io/docs/providers/aws/r/iam_instance_profile.html)
* [SPOT.IO Ocean](https://help.spot.io/ocean/ocean-overview-ecs/)

Please note, that you must have a vpc in tact, a security group is not mandatory, but your workers wouldn't be able to communicate. See the example for real life scenario usage.

## Usage

* [Example](example)

## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.12.0 |
| aws | ~> 2.53.0 |
| spotinst | ~> 1.14.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.53.0 |
| spotinst | ~> 1.14.0 |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | The name of the cluster, being used in other indetifiers as well | `string` | n/a | yes |
| efs\_security\_group | Should you want to work with efs, provide the security group | `string` | `""` | no |
| environment | This would help you distinguish between your different environments | `string` | n/a | yes |
| instance\_ssh\_key | The ssh key name to attach to the workers (not the actual key, but the key name in aws) | `string` | n/a | yes |
| instance\_subnets | List of subnets to spread the cluster workers on | `list(string)` | n/a | yes |
| root\_volume\_size | Workers volume size | `number` | `100` | no |
| security\_groups | List of security groups to attach to the workers | `list(string)` | `[]` | no |
| spotinst\_account | The spotinst account id | `string` | n/a | yes |
| spotinst\_token | The spotinst Token | `string` | n/a | yes |
| tags | A map of tags to add to ECS Cluster | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_id | The aws id of the cluster |
| cluster\_name | The name of the cluster |

## Authors

Module managed by [Yoad Fekete](https://github.com/yoadfe), contributors are welcome :)

## License

Apache 2 Licensed. See LICENSE for full details.
