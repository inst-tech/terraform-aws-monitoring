variable "actions" {
  type = list(string)
}

variable "prefix" {}

variable "default_tags" {
  type = map(string)
}
// Kinesis stream name
variable "kinesis_stream_id" {
  description = "Name of the kinesis stream to monitor"
  type        = string
}

// Kinesis Iterator Age Alarm Settings
variable "kinesis_iterator_age_error_threshold" {
  description = "The value against which the specified statistic is compared."
  default     = "1000000"
}

variable "kinesis_iterator_age_error_evaluation_periods" {
  description = "The number of periods over which data is compared to the specified threshold."
  default     = "1"
}

variable "kinesis_iterator_age_error_period" {
  description = "The period in seconds over which the specified stat is applied."
  default     = "300"
}

// Kinesis Write Throughput Alarm Settings
variable "kinesis_write_throughput_exceeded_threshold" {
  description = "The value against which the specified statistic is compared."
  default     = "10"
}

variable "kinesis_write_throughput_exceeded_evaluation_periods" {
  description = "The number of periods over which data is compared to the specified threshold."
  default     = "6"
}

variable "kinesis_write_throughput_exceeded_period" {
  description = "The period in seconds over which the specified stat is applied."
  default     = "300"
}
