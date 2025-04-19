variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for ECS services"
}

variable "security_groups" {
  type        = list(string)
  description = "List of security group IDs for ECS services"
}

