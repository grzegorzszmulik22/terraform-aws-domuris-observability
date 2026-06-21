variable "name" {
  type        = string
  description = "Alert topic name."
}

variable "email_endpoints" {
  type        = list(string)
  description = "Email endpoints subscribed to alerts."
  default     = []
}

variable "kms_key_id" {
  type        = string
  description = "Optional KMS key ID for SNS encryption."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to resources."
  default     = {}
}
