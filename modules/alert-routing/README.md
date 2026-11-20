# alert-routing

SNS topic that alarms publish to, with email subscriptions.

## What it creates

- SNS topic
- One email subscription per address in `email_endpoints`

## Security defaults

- Optional KMS encryption of the topic (`kms_key_id`)

## Usage

See [`examples/`](../../examples) for a full composition.

```hcl
module "alert_routing" {
  source = "git::https://github.com/grzegorzszmulik22/terraform-aws-domuris-observability.git//modules/alert-routing?ref=v0.2.0"
  # required inputs listed below
}
```

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `name` | Alert topic name. | `string` | n/a | yes |
| `email_endpoints` | Email endpoints subscribed to alerts. | `list(string)` | `[]` | no |
| `kms_key_id` | Optional KMS key ID for SNS encryption. | `string` | `null` | no |
| `tags` | Tags applied to resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `topic_arn` | SNS topic ARN. |
<!-- END_TF_DOCS -->
