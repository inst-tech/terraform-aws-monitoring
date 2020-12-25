variable "actions" {
  type = list(string)
}

variable "default_tags" {
  type = map(string)
}

variable "prefix" {}

variable "autoscaling_group_ids" {
  type = list(string)
}