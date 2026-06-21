output "canary_name" {
  description = "Canary name."
  value       = aws_synthetics_canary.this.name
}

output "canary_arn" {
  description = "Canary ARN."
  value       = aws_synthetics_canary.this.arn
}

output "role_arn" {
  description = "Canary execution role ARN."
  value       = aws_iam_role.this.arn
}
