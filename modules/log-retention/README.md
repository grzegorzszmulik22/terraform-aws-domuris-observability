# log-retention

Creates CloudWatch log groups with a fixed retention period and optional KMS encryption.

## What it creates

- One log group per name in `log_group_names`

## Security defaults

- Retention is always set (30 days by default), so logs do not accumulate indefinitely
- Optional KMS encryption (`kms_key_id`)

## Notes

This module creates the log groups. Do not point it at log groups that another module already manages (the platform ECS modules create their own `/ecs/<name>` groups).

## Usage

See [`examples/`](../../examples) for a full composition.

```hcl
module "log_retention" {
  source = "git::https://github.com/grzegorzszmulik22/terraform-aws-domuris-observability.git//modules/log-retention?ref=v0.1.1"
  # required inputs listed below
}
```

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `log_group_names` | CloudWatch log group names to manage. | `set(string)` | n/a | yes |
| `kms_key_id` | Optional KMS key ID for log group encryption. | `string` | `null` | no |
| `retention_in_days` | Retention period in days. | `number` | `30` | no |
| `tags` | Tags applied to log groups. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `log_group_arns` | CloudWatch log group ARNs. |
<!-- END_TF_DOCS -->
