# terraform-aws-domuris-observability

Reusable Terraform modules for application observability around a private AWS SaaS platform.

## Modules

```text
modules/
  alert-routing/     SNS topic and subscriptions for alarm notifications
  dashboard/         CloudWatch dashboard for ECS, ALB, RDS, and Redis
  log-retention/     Managed retention for application log groups
  synthetic-canary/  CloudWatch Synthetics canary for public health checks
```

## Operating Notes

The modules cover the parts that usually get missed during initial infrastructure work: retention, dashboards, external checks, and notification routing.

No production endpoints, account IDs, notification addresses, or state files should be committed.
