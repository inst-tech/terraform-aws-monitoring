variable "actions" {
  type = list(string)
}

variable "prefix" {}
variable "default_tags" {
  type = map(string)
}
variable "event_name" {}
variable "event_detail_type" {}

variable "event_bus_name" {
  default = "default"
}