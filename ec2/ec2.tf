resource "aws_cloudwatch_metric_alarm" "instance_statuscheck" {
  count                     = length(var.ec2_instance_ids)
  alarm_name                = join("-", compact([var.prefix, "StatusCheck: ${var.ec2_instance_ids[count.index]}"]))
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
  dimensions                = { InstanceId = var.ec2_instance_ids[count.index] }
}