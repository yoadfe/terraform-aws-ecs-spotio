variable "app_cluster_extra_sg" {
  type        = list(string)
  description = "A list of extra security groups to add to the cluter"
  default = []
}

variable "spotinst_account" {
  type        = string
  description = "The spotinst account id"
}

variable "spotinst_token" {
  type        = string
  description = "The spotinst Token"
}
