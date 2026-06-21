variable "dashboard_name" {
  type        = string
  description = "CloudWatch dashboard name."
}

variable "region" {
  type        = string
  description = "AWS region for dashboard metrics."
}

variable "ecs_cluster_name" {
  type        = string
  description = "ECS cluster name."
}

variable "ecs_service_names" {
  type        = list(string)
  description = "ECS service names to chart."
  default     = []
}

variable "alb_arn_suffix" {
  type        = string
  description = "ALB ARN suffix."
}

variable "target_group_arn_suffix" {
  type        = string
  description = "Target group ARN suffix."
}

variable "rds_instance_id" {
  type        = string
  description = "RDS instance identifier."
}

variable "redis_replication_group_id" {
  type        = string
  description = "Redis replication group identifier."
}
