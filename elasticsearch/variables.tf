variable "actions" {
  type = list(string)
}

variable "prefix" {}


variable "elasticsearch_domain_id" {}
variable "default_tags" {
  type = map(string)
}
## Elasticsearch

variable "free_storage_space_threshold" {
  description = "The minimum amount of available storage space in MegaByte."
  type        = number
  default     = 20480 ## 20 Gigabyte in MegaByte
}

variable "min_available_nodes" {
  description = "The minimum available (reachable) nodes to have"
  type        = number
  default     = 1
}

variable "cpu_utilization_threshold" {
  description = "The maximum percentage of CPU utilization"
  type        = number
  default     = 80

  # 80 percent in Percentage
}

variable "jvm_memory_pressure_threshold" {
  description = "The maximum percentage of the Java heap used for all data nodes in the cluster"
  type        = number
  default     = 80

  # 80 percent in Percentage
}

variable "master_cpu_utilization_threshold" {
  description = "The maximum percentage of CPU utilization of master nodes"
  type        = number
  default     = 80 # default same as `cpu_utilization_threshold` in Percentage
}

variable "master_jvm_memory_pressure_threshold" {
  description = "The maximum percentage of the Java heap used for master nodes in the cluster"
  type        = number
  default     = 80
  # default same as `jvm_memory_pressure_threshold` in Percentage
}