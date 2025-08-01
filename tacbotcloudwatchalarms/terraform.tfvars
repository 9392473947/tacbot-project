alarms = {
  high_cpu_alarm = {
    alarm_name          = "HighCPUUtilization"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = 2
    metric_name         = "CPUUtilization"
    namespace           = "AWS/EC2"
    period              = 120
    statistic           = "Average"
    threshold           = 80
    alarm_description   = "This alarm triggers when CPU is over 80%"
    alarm_actions       = ["arn:aws:sns:ap-south-1:992382670521:cloudwatch-alarm-topic"]
    dimensions          = {
      InstanceId = "give instance id"
    }
  }

  route53_health_check_alarm = {
    alarm_name          = "Route53-HealthCheck-Alarm"
    comparison_operator = "LessThanThreshold"
    evaluation_periods  = 2
    metric_name         = "HealthCheckStatus"
    namespace           = "AWS/Route53"
    period              = 60
    statistic           = "Minimum"
    threshold           = 1
    alarm_description   = "Alarm when Route53 health check fails"
    alarm_actions       = ["arn:aws:sns:ap-south-1:992382670521:cloudwatch-alarm-topic"]
    dimensions = {
      HealthCheckId = "31386e79-3fcb-44c6-9057-64397b608011"
    }
  
  }
}
