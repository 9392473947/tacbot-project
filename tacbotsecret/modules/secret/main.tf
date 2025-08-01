resource "aws_secretsmanager_secret" "secret" {
  name        = var.secret_name
  description = var.secret_description
  kms_key_id              = var.kms_key_id != "" ? var.kms_key_id : null
  tags = merge(
    var.owned_tags,
    {
      Name = "${var.projectname}-secret"
    }
  )
  
}

resource "aws_secretsmanager_secret_version" "my_secret_version" {
  secret_id     = aws_secretsmanager_secret.secret.id
  secret_string = jsonencode(var.secret_data)
}