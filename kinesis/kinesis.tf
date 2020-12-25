// Kinesis: Iterator Age
resource "aws_cloudwatch_metric_alarm" "_kinesis_iterator_age" {
  alarm_name          = "${var.prefix}-kinesis-${var.kinesis_stream_id}-high-iterator-age"
  alarm_description   = "The Get iterator age of ${var.kinesis_stream_id} is starting to lag behind"
  namespace           = "AWS/Kinesis"
  metric_name         = "GetRecords.IteratorAgeMilliseconds"
  statistic           = "Maximum"
  comparison_operator = "GreaterThanThreshold"
  threshold           = var.kinesis_iterator_age_error_threshold
  evaluation_periods  = var.kinesis_iterator_age_error_evaluation_periods
  period              = var.kinesis_iterator_age_error_period

  alarm_actions             = var.actions
  ok_actions                = var.actions
  insufficient_data_actions = var.actions

  dimensions = {
    StreamName = var.kinesis_stream_id
  }
  tags = var.default_tags
}

// Kinesis: Write Throughput Exceeded
resource "aws_cloudwatch_metric_alarm" "_kinesis_write_exceeded" {
  alarm_name          = "${var.prefix}-kinesis-${var.kinesis_stream_id}-write-exceeded"
  alarm_description   = "There are more writes going into ${var.kinesis_stream_id} than the chards can handle"
  namespace           = "AWS/Kinesis"
  metric_name         = "WriteProvisionedThroughputExceeded"
  statistic           = "Sum"
  comparison_operator = "GreaterThanThreshold"
  threshold           = var.kinesis_write_throughput_exceeded_threshold
  evaluation_periods  = var.kinesis_write_throughput_exceeded_evaluation_periods
  period              = var.kinesis_write_throughput_exceeded_period

  alarm_actions             = var.actions
  ok_actions                = var.actions
  insufficient_data_actions = var.actions

  dimensions = {
    StreamName = var.kinesis_stream_id
  }
  tags = var.default_tags
}