variable "secret_name" {
  description = "Name of the Secrets Manager secret"
  type        = string
}

variable "secret_description" {
  description = "Description of the secret"
  type        = string
  default     = "Managed by Terraform"
}
variable "secret_data" {
  description = "Key-value map for secret content"
  type        = map(string)
}
variable "owned_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}
variable "projectname" {
  
}
variable "kms_key_id" {
  description = "Optional KMS Key ID for encryption"
  type        = string
  default     = ""  # If not set, AWS default key will be used
}