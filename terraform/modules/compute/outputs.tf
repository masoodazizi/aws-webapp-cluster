output "bastion_sg" {
  value = aws_security_group.bastion.id
}

output "ecs_alb_sg" {
  value = aws_security_group.ecs_alb.id
}

output "ecs_instance_sg" {
  value = aws_security_group.ecs_instance.id
}

output "maintenance_sg" {
  value = aws_security_group.maintenance.id
}

