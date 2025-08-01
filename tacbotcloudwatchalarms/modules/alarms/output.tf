output "cloudwatch_alarm_names" {
  value = { for k, v in aws_cloudwatch_metric_alarm.alarm : k => v.alarm_name }
}
