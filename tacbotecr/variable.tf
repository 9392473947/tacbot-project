variable "repo_name" {
  description = "enter the name of the repo"
  type = string
  
}
variable "owned_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}
variable "projectname" {
  description = "project name"
  type = string
  
}
variable "kms_key_arn" {
    description = "give the kms key arn"
    type = string
  
}