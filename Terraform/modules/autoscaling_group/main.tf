resource "aws_autoscaling_group" "my_asg1" {
  vpc_zone_identifier = var.vpc_zone_identifier
  desired_capacity   = var.desired_capacity
  max_size           = var.max_size
  min_size           = var.min_size
  target_group_arns  = var.target_group_arns
  name = var.asgname
  launch_template {
    id      = var.launch_template
    version = "$Latest"
  }
  
     tag {
        key                 = "Name"
        value                = var.value
        propagate_at_launch = true
      }
  
}