data "aws_region" "current" {}
variable "autoscaling_group_id" {}
variable "ecs_cluster_id" {}
variable "ecs_cluster_arn" {}
variable "default_tags" {
  type = map(string)
}
variable "prefix" {}
