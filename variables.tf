variable "subnet_ids" {
  description = "List of subnet IDs for ECS services"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security group IDs for ECS services"
  type        = list(string)
}

