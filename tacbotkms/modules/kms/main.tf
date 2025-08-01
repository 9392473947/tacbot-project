resource "aws_kms_key" "cmk" {
  description             = var.description
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = var.enable_key_rotation
  policy = var.kms_policy != null ? var.kms_policy : null
  tags = merge(
    var.owned_tags,
    {
      Name = "${var.projectname}-kms"
    }
  )
}

resource "aws_kms_alias" "cmk_alias" {
  name          = "alias/${var.alias}"
  target_key_id = aws_kms_key.cmk.id
}