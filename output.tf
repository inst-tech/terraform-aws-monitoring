output "ec2_instance_ids" {
  value = concat(module.ec2_instances.*.instance_ids, module.autoscaling.ec2_instance_ids)
}