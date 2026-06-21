variable "aws_region" {
  type        = string
  description = "AWS region."
  default     = "eu-central-1"
}

variable "name" {
  type        = string
  description = "Name prefix."
  default     = "domuris-staging"
}

variable "alarm_emails" {
  type        = list(string)
  description = "Optional email notification endpoints."
  default     = []
}

variable "ecs_cluster_name" {
  type        = string
  description = "ECS cluster name."
  default     = "domuris-staging"
}

variable "ecs_service_names" {
  type        = list(string)
  description = "ECS service names."
  default     = ["domuris-staging-api", "domuris-staging-worker", "domuris-staging-qdrant"]
}

variable "alb_arn_suffix" {
  type        = string
  description = "ALB ARN suffix."
  default     = "app/domuris-staging/0000000000000000"
}

variable "target_group_arn_suffix" {
  type        = string
  description = "Target group ARN suffix."
  default     = "targetgroup/domuris-staging-api/0000000000000000"
}

variable "rds_instance_id" {
  type        = string
  description = "RDS instance identifier."
  default     = "domuris-staging-postgres"
}

variable "redis_replication_group_id" {
  type        = string
  description = "Redis replication group identifier."
  default     = "domuris-staging-redis"
}

variable "canary_artifact_s3_location" {
  type        = string
  description = "S3 URI for canary artifacts."
  default     = "s3://example-synthetics-artifacts/domuris"
}

variable "canary_artifact_bucket_arn" {
  type        = string
  description = "Canary artifact bucket ARN."
  default     = "arn:aws:s3:::example-synthetics-artifacts"
}

variable "canary_zip_file_path" {
  type        = string
  description = "Path to the generated canary zip."
  default     = "./canary.zip"
}
