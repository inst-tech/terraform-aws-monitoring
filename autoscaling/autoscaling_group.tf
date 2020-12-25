resource "aws_autoscaling_notification" "slack_notifications" {
  count = length(var.actions)

  group_names = var.autoscaling_group_ids

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]
  topic_arn = var.actions[count.index]
}

module "autoscaling_group_instances" {
  count                    = length(var.autoscaling_group_ids)
  source                   = "../autoscaling_group_instances"
  actions                  = var.actions
  prefix                   = var.prefix
  aws_autoscaling_group_id = var.autoscaling_group_ids[count.index]
}
