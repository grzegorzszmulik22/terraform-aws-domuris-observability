variable "log_group_names" {
  type        = set(string)
  description = "CloudWatch log group names to manage."
}

variable "retention_in_days" {
  type        = number
  description = "Retention period in days."
  default     = 30
}

variable "kms_key_id" {
  type        = string
  description = "Optional KMS key ID for log group encryption."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to log groups."
  default     = {}
}
