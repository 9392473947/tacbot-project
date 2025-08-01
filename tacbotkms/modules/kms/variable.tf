variable "description" {
  type        = string
  description = "Description of the CMK"
}

variable "deletion_window_in_days" {
  type        = number
  default     = 30
  description = "Waiting period before key is deleted"
}

variable "enable_key_rotation" {
  type        = bool
  default     = true
  description = "Enable automatic key rotation"
}

variable "kms_policy" {
  type        = string
  description = "KMS Key Policy as a JSON string"
  default     = null
}

variable "alias" {
  type        = string
  description = "Alias name for the CMK"
}

variable "owned_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}
variable "projectname" {
  description = "give the project"
  type = string
  
}
