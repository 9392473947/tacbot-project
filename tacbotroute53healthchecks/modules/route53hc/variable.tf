variable "fqdn" {
  type        = string
  description = "Fully qualified domain name to check"
}

variable "port" {
  type        = number
  description = "Port to check"
}

variable "type" {
  type        = string
  description = "Type of check: HTTP, HTTPS, or TCP"
}

variable "resource_path" {
  type        = string
  description = "Path to check (used for HTTP/S)"
  default     = "/"
}

variable "failure_threshold" {
  type        = number
  default     = 3
  description = "Number of failed checks before unhealthy"
}

variable "request_interval" {
  type        = number
  default     = 30
  description = "Interval in seconds between checks"
}

variable "owned_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

variable "projectname" {
  
}

