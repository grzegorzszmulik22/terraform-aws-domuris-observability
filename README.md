# terraform-aws-domuris-observability

Terraform modules for the observability layer of an AWS SaaS platform: alert routing, a CloudWatch dashboard, log retention and a synthetic health-check canary.

They were built for Domuris, a property-management SaaS platform, alongside [terraform-aws-domuris-platform](https://github.com/grzegorzszmulik22/terraform-aws-domuris-platform), and take resource names and identifiers as inputs.

## Modules

| Module | Creates | Key security defaults |
|--------|---------|-----------------------|
| [alert-routing](modules/alert-routing) | SNS topic and email subscriptions for alarms | Optional KMS encryption of the topic |
| [dashboard](modules/dashboard) | CloudWatch dashboard: ECS CPU/memory, ALB 5xx and healthy hosts, RDS, Redis | - |
| [log-retention](modules/log-retention) | CloudWatch log groups with a fixed retention period | Retention always set (30 days by default); optional KMS encryption |
| [synthetic-canary](modules/synthetic-canary) | CloudWatch Synthetics canary, IAM role, failure alarm | S3 access limited to the artifact bucket; metrics limited to the `CloudWatchSynthetics` namespace; missing data alarms |

Each module has its own README with the full inputs and outputs tables.

## Usage

[`examples/basic`](examples/basic) wires all four modules together. A trimmed excerpt:

```hcl
module "alerts" {
  source = "git::https://github.com/grzegorzszmulik22/terraform-aws-domuris-observability.git//modules/alert-routing?ref=v0.1.1"

  name            = "domuris-staging-alerts"
  email_endpoints = var.alarm_emails
}

module "canary" {
  source = "git::https://github.com/grzegorzszmulik22/terraform-aws-domuris-observability.git//modules/synthetic-canary?ref=v0.1.1"

  name                 = "domuris-staging-health"
  artifact_s3_location = "s3://example-synthetics-artifacts/domuris"
  artifact_bucket_arn  = "arn:aws:s3:::example-synthetics-artifacts"
  zip_file_path        = "./canary.zip"
  alarm_topic_arn      = module.alerts.topic_arn
}
```

The canary script is not included; build `canary.zip` (Node.js handler at `index.handler`) in CI and pass its path. The example's identifiers (ALB suffixes, bucket names) are placeholders.

## Requirements

| Name | Version |
|------|---------|
| Terraform | >= 1.6.0 |
| [hashicorp/aws](https://registry.terraform.io/providers/hashicorp/aws) | >= 5.0 |

Validated against AWS provider 5.x and 6.x.

## Security defaults

- SNS topics and log groups accept a KMS key (`kms_key_id`); encryption is applied only when one is passed.
- Every managed log group gets a retention period.
- The canary role can write only to the given artifact bucket and publish metrics only to the `CloudWatchSynthetics` namespace (the ENI permissions used for VPC canaries are granted on `*`).
- The canary failure alarm treats missing data as breaching, so a canary that stops running also alerts.

## Validate locally

```bash
terraform fmt -recursive -check
bash scripts/terraform-validate.sh   # terraform init -backend=false && terraform validate in every module and example
```

No AWS credentials are needed for either command. The same checks run in GitHub Actions on every push and pull request (`.github/workflows/terraform.yml`).

## License

[MIT](LICENSE)
