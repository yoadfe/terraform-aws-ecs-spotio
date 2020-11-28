variable "cluster_name" {
  type        = string
  description = "The name of the cluster, being used in other indetifiers as well"
}

variable "environment" {
  type        = string
  description = "This would help you distinguish between your different environments"
}

variable "instance_ssh_key" {
  type        = string
  description = "The ssh key name to attach to the workers (not the actual key, but the key name in aws)"
}

variable "instance_subnets" {
  type        = list(string)
  description = "List of subnets to spread the cluster workers on"
}

variable "root_volume_size" {
  type        = number
  description = "Workers volume size"
  default     = 100
}

variable "security_groups" {
  type        = list(string)
  description = "List of security groups to attach to the workers"
  default     = []
}

variable "efs_security_group" {
  type        = string
  description = "Should you want to work with efs, provide the security group"
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to ECS Cluster"
  default     = {}
}

variable "spotinst_account" {
  type        = string
  description = "The spotinst account id"
}

variable "spotinst_token" {
  type        = string
  description = "The spotinst Token"
}
