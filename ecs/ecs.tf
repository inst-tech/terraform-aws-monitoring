resource "aws_cloudwatch_metric_alarm" "ecs_memory_reservation_high" {
  alarm_name          = "${var.prefix}-${var.ecs_cluster_id}-MemoryReservation-HIGH"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "4"
  metric_name         = "MemoryReservation"
  namespace           = "AWS/ECS"
  period              = "300"
  statistic           = "Average"
  threshold           = var.memory_reservation_high_threshold

  dimensions = {
    ClusterName = var.ecs_cluster_id
  }

  alarm_actions             = concat(var.actions, var.memory_reservation_high_additional_actions)
  ok_actions                = var.actions
  insufficient_data_actions = var.actions
}

resource "aws_cloudwatch_metric_alarm" "ecs_memory_reservation_low" {
  alarm_name          = "${var.prefix}-${var.ecs_cluster_id}-MemoryReservation-LOW"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "4"
  metric_name         = "MemoryReservation"
  namespace           = "AWS/ECS"
  period              = "300"
  statistic           = "Average"
  threshold           = var.memory_reservation_low_threshold

  dimensions = {
    ClusterName = var.ecs_cluster_id
  }

  alarm_actions             = concat(var.actions, var.memory_reservation_low_additional_actions)
  ok_actions                = var.actions
  insufficient_data_actions = var.actions
}

resource "aws_cloudwatch_metric_alarm" "ecs_cpu_reservation_high" {
  alarm_name          = "${var.prefix}-${var.ecs_cluster_id}-MemoryReservation-HIGH"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "4"
  metric_name         = "CPUReservation"
  namespace           = "AWS/ECS"
  period              = "300"
  statistic           = "Average"
  threshold           = var.cpu_reservation_high_threshold

  dimensions = {
    ClusterName = var.ecs_cluster_id
  }

  alarm_actions             = concat(var.actions, var.cpu_reservation_high_additional_actions)
  ok_actions                = var.actions
  insufficient_data_actions = var.actions
}

resource "aws_cloudwatch_metric_alarm" "ecs_cpu_reservation_low" {
  alarm_name          = "${var.prefix}-${var.ecs_cluster_id}-MemoryReservation-LOW"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "4"
  metric_name         = "CPUReservation"
  namespace           = "AWS/ECS"
  period              = "300"
  statistic           = "Average"
  threshold           = var.cpu_reservation_low_threshold

  dimensions = {
    ClusterName = var.ecs_cluster_id
  }

  alarm_actions             = concat(var.actions, var.cpu_reservation_low_additional_actions)
  ok_actions                = var.actions
  insufficient_data_actions = var.actions
}

resource "aws_cloudwatch_metric_alarm" "ecs_memory_utilization_high" {
  alarm_name          = "${var.prefix}-${var.ecs_cluster_id}-MemoryUtilization-HIGH"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "4"
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = "300"
  statistic           = "Average"
  threshold           = var.memory_utilization_high_threshold

  dimensions = {
    ClusterName = var.ecs_cluster_id
  }

  alarm_actions             = concat(var.actions, var.memory_utilization_high_additional_actions)
  ok_actions                = var.actions
  insufficient_data_actions = var.actions
}

resource "aws_cloudwatch_metric_alarm" "ecs_memory_utilization_low" {
  alarm_name          = "${var.prefix}-${var.ecs_cluster_id}-MemoryUtilization-LOW"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "4"
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = "300"
  statistic           = "Average"
  threshold           = var.memory_utilization_low_threshold

  dimensions = {
    ClusterName = var.ecs_cluster_id
  }

  alarm_actions             = concat(var.actions, var.memory_utilization_low_additional_actions)
  ok_actions                = var.actions
  insufficient_data_actions = var.actions
}

resource "aws_cloudwatch_metric_alarm" "ecs_cpu_utilization_high" {
  alarm_name          = "${var.prefix}-${var.ecs_cluster_id}-MemoryUtilization-HIGH"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "4"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "300"
  statistic           = "Average"
  threshold           = var.cpu_utilization_high_threshold

  dimensions = {
    ClusterName = var.ecs_cluster_id
  }

  alarm_actions             = concat(var.actions, var.cpu_utilization_high_additional_actions)
  ok_actions                = var.actions
  insufficient_data_actions = var.actions
}

resource "aws_cloudwatch_metric_alarm" "ecs_cpu_utilization_low" {
  alarm_name          = "${var.prefix}-${var.ecs_cluster_id}-MemoryUtilization-LOW"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "4"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "300"
  statistic           = "Average"
  threshold           = var.cpu_utilization_low_threshold

  dimensions = {
    ClusterName = var.ecs_cluster_id
  }

  alarm_actions             = concat(var.actions, var.cpu_utilization_low_additional_actions)
  ok_actions                = var.actions
  insufficient_data_actions = var.actions
}