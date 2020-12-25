output "ec2_instance_ids" {
  value = module.autoscaling_group_instances.*.instance_ids
}