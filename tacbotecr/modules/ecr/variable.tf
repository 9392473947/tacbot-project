variable "name" {
  description = "Name of the ECR repository"
  type        = string
}
variable "owned_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}
variable "projectname" {
  description = "give project name"
  type = string
}
variable "lifecycle_policy" {
  description = "Optional lifecycle policy JSON"
  type        = string
  default     = ""
}
variable "kms_key_arn" {
  description = "give kms arn"
  type = string
  
}