output "alert_topic_arn" {
  description = "Alert topic ARN."
  value       = module.alerts.topic_arn
}

output "dashboard_name" {
  description = "CloudWatch dashboard name."
  value       = module.dashboard.dashboard_name
}

output "canary_name" {
  description = "Synthetic canary name."
  value       = module.canary.canary_name
}
