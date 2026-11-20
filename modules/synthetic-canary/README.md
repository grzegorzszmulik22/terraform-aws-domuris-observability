# synthetic-canary

CloudWatch Synthetics canary that runs a scripted health check against the application, with a failure alarm.

## What it creates

- IAM role for the canary
- Canary from a caller-supplied zip (`index.handler`), run on `schedule_expression` (every 5 minutes by default)
- Optional VPC placement
- Optional alarm on the `Failed` metric, sent to `alarm_topic_arn`

## Security defaults

- S3 permissions limited to the artifact bucket
- `cloudwatch:PutMetricData` limited to the `CloudWatchSynthetics` namespace
- The failure alarm treats missing data as breaching, so a canary that stops running also alerts

## Notes

The canary script itself is not part of this module; build the zip in CI and pass its path.

## Usage

See [`examples/`](../../examples) for a full composition.

```hcl
module "synthetic_canary" {
  source = "git::https://github.com/grzegorzszmulik22/terraform-aws-domuris-observability.git//modules/synthetic-canary?ref=v0.2.0"
  # required inputs listed below
}
```

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `artifact_bucket_arn` | S3 bucket ARN for canary artifacts. | `string` | n/a | yes |
| `artifact_s3_location` | S3 URI where canary artifacts are stored. | `string` | n/a | yes |
| `name` | Canary name. | `string` | n/a | yes |
| `zip_file_path` | Path to the canary zip file. | `string` | n/a | yes |
| `alarm_topic_arn` | Optional SNS topic ARN for canary alarms. | `string` | `null` | no |
| `runtime_version` | CloudWatch Synthetics runtime version. | `string` | `"syn-nodejs-puppeteer-9.1"` | no |
| `schedule_expression` | Canary schedule expression. | `string` | `"rate(5 minutes)"` | no |
| `security_group_ids` | Optional security group IDs for VPC canaries. | `list(string)` | `[]` | no |
| `subnet_ids` | Optional subnet IDs for VPC canaries. | `list(string)` | `[]` | no |
| `tags` | Tags applied to resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `canary_arn` | Canary ARN. |
| `canary_name` | Canary name. |
| `role_arn` | Canary execution role ARN. |
<!-- END_TF_DOCS -->
