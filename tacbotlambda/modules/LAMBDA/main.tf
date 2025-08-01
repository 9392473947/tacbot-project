
resource "aws_lambda_function" "fun" {
    function_name = var.lambda_function_name
    filename = var.filename
    handler = "lambda_function.lambda_handler"
    runtime = "python3.11"
    role = var.role
    timeout = 900
    memory_size = 512
    source_code_hash = filebase64sha256(var.filename)

    vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

    environment {
        variables = {
            DEST_BUCKET = "nill"
            
        }
    }
    tags = merge(
    var.owned_tags,
    {
    Name = "${var.projectname}-lambda"
    }
  )
    
}


