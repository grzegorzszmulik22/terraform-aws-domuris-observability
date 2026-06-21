output "log_group_arns" {
  description = "CloudWatch log group ARNs."
  value       = { for name, group in aws_cloudwatch_log_group.this : name => group.arn }
}
