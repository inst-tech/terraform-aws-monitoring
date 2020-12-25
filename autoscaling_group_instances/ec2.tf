## trying to figure out a way to do this when no instances are present or matched.

/*data "aws_instances" "instances" {
  instance_tags        = {
     aws:autoscaling:groupName =
  }
  instance_state_names = ["running"]
}

locals {
  instances = zipmap(data.aws_instances.instances.ids, data.aws_instances.instances.private_ips)
}*/

/*
data "external" "aws_asg_instances" {
  program = ["bin/aws_autoscaling_group_instances", var.aws_autoscaling_group_id, "us-east-2"]
}

resource "aws_cloudwatch_metric_alarm" "instance_group_statuscheck" {
  count = length(data.external.aws_asg_instances.
  alarm_name                = join("-", compact([var.prefix, "StatusCheck: ${each.value}"]))
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "StatusCheckFailed"
  namespace                 = "AWS/EC2"
  period                    = "300"
  statistic                 = "Maximum"
  threshold                 = "1.0"
  alarm_description         = "EC2 Status Check"
  alarm_actions             = var.actions
  ok_actions                = var.actions
  insufficient_data_actions = var.actions
  dimensions                = { InstanceId = each.value }
}*/
