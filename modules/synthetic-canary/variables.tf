variable "name" {
  type        = string
  description = "Canary name."
}

variable "artifact_s3_location" {
  type        = string
  description = "S3 URI where canary artifacts are stored."
}

variable "artifact_bucket_arn" {
  type        = string
  description = "S3 bucket ARN for canary artifacts."
}

variable "zip_file_path" {
  type        = string
  description = "Path to the canary zip file."
}

variable "runtime_version" {
  type        = string
  description = "CloudWatch Synthetics runtime version."
  default     = "syn-nodejs-puppeteer-9.1"
}

variable "schedule_expression" {
  type        = string
  description = "Canary schedule expression."
  default     = "rate(5 minutes)"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Optional subnet IDs for VPC canaries."
  default     = []
}

variable "security_group_ids" {
  type        = list(string)
  description = "Optional security group IDs for VPC canaries."
  default     = []
}

variable "alarm_topic_arn" {
  type        = string
  description = "Optional SNS topic ARN for canary alarms."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to resources."
  default     = {}
}
