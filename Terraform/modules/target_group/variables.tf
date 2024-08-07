variable "name" {
  description = "The name of the target group"
  type        = string
}

variable "port" {
  description = "The port on which the targets receive traffic"
  type        = number
}

variable "protocol" {
  description = "The protocol used for routing traffic to the targets"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID in which the target group is created"
  type        = string
}

variable "tags_tg" {
  description = "Tags for the target group"
  type        = map(string)
}

variable "health_check_interval" {
  description = "The amount of time, in seconds, between health checks of an individual target"
  type        = number
}

variable "health_check_path" {
  description = "The destination for health checks on the targets"
  type        = string
}

variable "health_check_protocol" {
  description = "The protocol to use for health checks"
  type        = string
}

variable "health_check_timeout" {
  description = "The amount of time, in seconds, to wait when receiving a response from a health check"
  type        = number
}

variable "health_check_unhealthy_threshold" {
  description = "The number of consecutive health check failures required before considering a target unhealthy"
  type        = number
}

variable "health_check_healthy_threshold" {
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  type        = number
}
