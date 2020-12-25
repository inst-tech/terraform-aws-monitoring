resource "aws_cloudwatch_event_rule" "autoscaling_events" {
  name        = "${var.prefix}-autoscaling-events"
  description = "Capture AWS Autosclaing Events"

  event_pattern = <<EOF
{
  "eventType": [
    "UpdateAutoScalingGroup"
  ]
}
EOF
  tags          = var.default_tags
}

resource "aws_cloudwatch_event_target" "autoscaling_events" {
  count = length(var.actions)
  rule  = aws_cloudwatch_event_rule.autoscaling_events.name
  arn   = var.actions[count.index]
}