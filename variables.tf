variable "default_tags" {
  type = map(string)
}

variable "ec2_instance_ids" {
  type = list(string)
}

variable "ec2_instance_tags" {
  type = map(string)
}

variable "prefix" {
  type = string
}
## Module Specific
variable "actions" {
  type = list(string)
}

variable "rds_instance_ids" {
  type = list(string)
}

variable "elasticsearch_domain_ids" {
  type = list(string)
}

variable "kinesis_stream_ids" {
  type = list(string)
}

variable "autoscaling_group_ids" {
  type = list(string)
}