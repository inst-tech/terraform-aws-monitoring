output "increase_by_one_policy_arn" {
  value = aws_autoscaling_policy.increase_by_one.arn
}

output "increase_by_one_policy_id" {
  value = aws_autoscaling_policy.increase_by_one.id
}

output "decrease_by_one_policy_arn" {
  value = aws_autoscaling_policy.decrease_by_one.arn
}

output "decrease_by_one_policy_id" {
  value = aws_autoscaling_policy.decrease_by_one.id
}
