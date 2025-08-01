resource "aws_sns_topic" "this" {
  name = var.topic_name
  tags = merge(
    var.owned_tags,
    {
      Name = "${var.projectname}-sns"
    }
  )
}

resource "aws_sns_topic_subscription" "this" {
  count     = length(var.subscriptions)
  topic_arn = aws_sns_topic.this.arn
  protocol  = "email"
  endpoint  = var.subscriptions[count.index]
}
