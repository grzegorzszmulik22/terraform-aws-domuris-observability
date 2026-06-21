locals {
  tags = {
    Project     = "domuris"
    Environment = "staging"
    ManagedBy   = "terraform"
  }
}

module "alerts" {
  source = "../../modules/alert-routing"

  name            = "${var.name}-alerts"
  email_endpoints = var.alarm_emails
  tags            = local.tags
}

module "log_retention" {
  source = "../../modules/log-retention"

  log_group_names = [
    "/ecs/${var.name}-api",
    "/ecs/${var.name}-worker",
    "/ecs/${var.name}-qdrant"
  ]
  retention_in_days = 30
  tags              = local.tags
}

module "dashboard" {
  source = "../../modules/dashboard"

  dashboard_name             = "${var.name}-platform"
  region                     = var.aws_region
  ecs_cluster_name           = var.ecs_cluster_name
  ecs_service_names          = var.ecs_service_names
  alb_arn_suffix             = var.alb_arn_suffix
  target_group_arn_suffix    = var.target_group_arn_suffix
  rds_instance_id            = var.rds_instance_id
  redis_replication_group_id = var.redis_replication_group_id
}

module "canary" {
  source = "../../modules/synthetic-canary"

  name                 = "${var.name}-health"
  artifact_s3_location = var.canary_artifact_s3_location
  artifact_bucket_arn  = var.canary_artifact_bucket_arn
  zip_file_path        = var.canary_zip_file_path
  alarm_topic_arn      = module.alerts.topic_arn
  tags                 = local.tags
}
