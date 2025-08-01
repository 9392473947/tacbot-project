variable "topic_name" {
    description = "give the sns topic"
    type = string
  
}
variable "subscriptions" {
  type        = list(string)
  description = "List of email endpoints to subscribe"
}
variable "owned_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}
variable "projectname" {
  
}