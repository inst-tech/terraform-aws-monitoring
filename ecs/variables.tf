variable "actions" {
  type = list(string)
}

variable "prefix" {}

variable "ecs_cluster_id" {
  type        = string
  description = "The name of the ECS cluster to monitor"
}

variable "cpu_utilization_high_threshold" {
  type        = number
  description = "The maximum percentage of CPU utilization average"
  default     = 80
}

variable "cpu_utilization_low_threshold" {
  type        = number
  description = "The minimum percentage of CPU utilization average"
  default     = 20
}

variable "memory_utilization_high_threshold" {
  type        = number
  description = "The maximum percentage of Memory utilization average"
  default     = 80
}

variable "memory_utilization_low_threshold" {
  type        = number
  description = "The minimum percentage of Memory utilization average"
  default     = 20
}

variable "memory_reservation_high_threshold" {
  type        = number
  description = "The maximum percentage of Memory reservation average"
  default     = 60
}

variable "memory_reservation_low_threshold" {
  type        = number
  description = "The minimum percentage of Memory reservation average"
  default     = 40
}

variable "cpu_reservation_high_threshold" {
  type        = number
  description = "The maximum percentage of CPU reservation average"
  default     = 60
}

variable "cpu_reservation_low_threshold" {
  type        = number
  description = "The minimum percentage of CPU reservation average"
  default     = 40
}

variable "memory_reservation_low_additional_actions" {
  type    = list(string)
  default = []
}

variable "memory_reservation_high_additional_actions" {
  type    = list(string)
  default = []
}

variable "cpu_reservation_low_additional_actions" {
  type    = list(string)
  default = []
}

variable "cpu_reservation_high_additional_actions" {
  type    = list(string)
  default = []
}

variable "memory_utilization_low_additional_actions" {
  type    = list(string)
  default = []
}

variable "memory_utilization_high_additional_actions" {
  type    = list(string)
  default = []
}

variable "cpu_utilization_low_additional_actions" {
  type    = list(string)
  default = []
}

variable "cpu_utilization_high_additional_actions" {
  type    = list(string)
  default = []
}