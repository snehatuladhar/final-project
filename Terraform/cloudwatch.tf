module "rds-autoscaling_alarm" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
  version = "~> 3.0"

  alarm_name          = "rdstrigger"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  threshold           = 70
  period              = "60"
  unit                = "Percent"
  namespace           = "AWS/RDS"
  metric_name         = "CPUUtilization"  
  statistic           = "Average"

  alarm_actions = [
    module.sns_topic.topic_arn  # Reference to SNS topic
  ]
  dimensions = {
    DBInstanceIdentifier = module.db.db_instance_id  # Reference the RDS instance ID from module output
  }
}
