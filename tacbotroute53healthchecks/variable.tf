variable "route53_health_checks" {
  type = map(object({
    fqdn              = string
    port              = number
    type              = string
    resource_path     = string
    failure_threshold = number
    request_interval  = number
  }))
}
variable "owned_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}
variable "projectname" {
  description = "The project name"
  type        = string
}