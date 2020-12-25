module "ecs_task_state_change" {
  source            = "./eventbridge"
  actions           = var.actions
  event_detail_type = "ECS Task State Change"
  event_name        = "ecs-task-state-change"
  prefix            = var.prefix
  default_tags      = var.default_tags
}

module "ecs_service_action" {
  source            = "./eventbridge"
  actions           = var.actions
  event_detail_type = "ECS Service Action"
  event_name        = "ecs-service-action"
  prefix            = var.prefix
  default_tags      = var.default_tags
}

module "aws_health" {
  source            = "./eventbridge"
  actions           = var.actions
  event_detail_type = "AWS Health Event"
  event_name        = "aws-health"
  prefix            = var.prefix
  default_tags      = var.default_tags
}

module "ec2_instance_state_change" {
  source            = "./eventbridge"
  actions           = var.actions
  event_detail_type = "EC2 Instance State-change Notification"
  event_name        = "ec2-instance-state-change"
  prefix            = var.prefix
  default_tags      = var.default_tags
}

module "calendar_state_change" {
  source            = "./eventbridge"
  actions           = var.actions
  event_detail_type = "Calendar State Change"
  event_name        = "calendar-state-change"
  prefix            = var.prefix
  default_tags      = var.default_tags
}

module "maintenance_window_state_change" {
  source            = "./eventbridge"
  actions           = var.actions
  event_detail_type = "Maintenance Window State-change Notification"
  event_name        = "maintenance-window-state-change"
  prefix            = var.prefix
  default_tags      = var.default_tags
}

module "instance_inventory" {
  source            = "./eventbridge"
  actions           = var.actions
  event_detail_type = "Inventory Resource State Change"
  event_name        = "instance_inventory"
  prefix            = var.prefix
  default_tags      = var.default_tags
}

module "kinesis" {
  count             = length(var.kinesis_stream_ids)
  source            = "./kinesis"
  actions           = var.actions
  prefix            = var.prefix
  kinesis_stream_id = var.kinesis_stream_ids[count.index]
  default_tags      = var.default_tags
}

module "elasticsearch" {
  count                   = length(var.elasticsearch_domain_ids)
  source                  = "./elasticsearch"
  actions                 = var.actions
  prefix                  = var.prefix
  elasticsearch_domain_id = var.elasticsearch_domain_ids[count.index]
  default_tags            = var.default_tags
}

module "rds" {
  count           = length(var.rds_instance_ids)
  source          = "./rds"
  actions         = var.actions
  prefix          = var.prefix
  rds_instance_id = var.rds_instance_ids[count.index]
  default_tags    = var.default_tags
}

module "autoscaling" {
  source                = "./autoscaling"
  actions               = var.actions
  autoscaling_group_ids = var.autoscaling_group_ids
  prefix                = var.prefix
  default_tags          = var.default_tags
}

module "ec2_instances" {
  source           = "./ec2"
  actions          = var.actions
  ec2_instance_ids = var.ec2_instance_ids
  prefix           = var.prefix
}