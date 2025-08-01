module "lambda" {
    source = "./modules/LAMBDA"
    filename = var.filename
    lambda_function_name = var.lambda_function_name
    role = aws_iam_role.lambda_role.arn
    subnet_ids           = var.subnet_ids
    security_group_ids   = [aws_security_group.lambda_sg.id]
    owned_tags = var.owned_tags
    projectname = var.projectname
}


resource "aws_cloudwatch_event_rule" "lambda_trigger" {
  name                = "imap_process_schedular_dev"
  description         = "This scheduler triggers dev lambdas every 1 minute"
  schedule_expression = "cron(0/1 * * * ? *)"

  tags = merge(
    var.owned_tags,
    {
    Name = "${var.projectname}-private-rt"
    }
  )
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "lambda-72b39e78-0203-485f-9616-a933239e505d"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.lambda_function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_trigger.arn
}

resource "aws_cloudwatch_event_target" "trigger_lambda" {
  rule      = aws_cloudwatch_event_rule.lambda_trigger.name
  target_id = "invokeLambda"
  arn       = module.lambda.lambda_function_arn
}
