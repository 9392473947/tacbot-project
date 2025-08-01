variable "alarms" {
  description = "Map of CloudWatch alarm configurations"
  type = map(object({
    alarm_name          = string
    comparison_operator = string
    evaluation_periods  = number
    metric_name         = string
    namespace           = string
    period              = number
    statistic           = string
    threshold           = number
    alarm_description   = string
    alarm_actions       = list(string)
    dimensions          = map(string)
  }))
}
