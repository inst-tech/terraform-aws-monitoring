resource "aws_cloudwatch_event_rule" "event_rule" {
  name        = "${var.prefix}-${var.event_name}-events"
  description = var.event_detail_type

  event_pattern = <<EOF
{
  "detail-type": [
    "${var.event_detail_type}"
  ]
}
EOF
  tags          = var.default_tags
}

resource "aws_cloudwatch_event_target" "event_target" {
  count = length(var.actions)
  rule  = aws_cloudwatch_event_rule.event_rule.name
  arn   = var.actions[count.index]
}