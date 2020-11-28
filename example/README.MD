# Module Usage example

This example shows how to utilize the module.
You must create a spot.io account and provide the account id and token to this module.

## Usage

To run this example you need to execute:

```bash
terraform init
terraform plan
terraform apply
```

Note that this example may create resources which can cost money (AWS EC2 instances, for example). Run `terraform destroy` when you don't need these resources.

## Explanation

Current version creates an high-available VPC with instances that are attached to ECS. 

ECS tasks can be run on these instances but they are not exposed to inbound connections (e.g - No load balancer)

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


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app\_cluster\_extra\_sg | A list of extra security groups to add to the cluter | `list(string)` | `[]` | no |
| spotinst\_account | The spotinst account id | `string` | n/a | yes |
| spotinst\_token | The spotinst Token | `string` | n/a | yes |

## Outputs

No output.
