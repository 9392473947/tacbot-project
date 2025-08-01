output "kms_key_arn" {
  description = "ARN of the customer managed KMS key"
  value       = module.kms.kms_key_arn1
}