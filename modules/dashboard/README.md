# dashboard

CloudWatch dashboard for the platform's ECS, ALB, RDS and Redis metrics.

## What it creates

- ECS CPU and memory for each listed service
- ALB target 5xx count and healthy host count
- RDS CPU, free storage and connections
- Redis engine CPU, connections and evictions

## Usage

See [`examples/`](../../examples) for a full composition.

```hcl
module "dashboard" {
  source = "git::https://github.com/grzegorzszmulik22/terraform-aws-domuris-observability.git//modules/dashboard?ref=v0.2.0"
  # required inputs listed below
}
```

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `alb_arn_suffix` | ALB ARN suffix. | `string` | n/a | yes |
| `dashboard_name` | CloudWatch dashboard name. | `string` | n/a | yes |
| `ecs_cluster_name` | ECS cluster name. | `string` | n/a | yes |
| `rds_instance_id` | RDS instance identifier. | `string` | n/a | yes |
| `redis_replication_group_id` | Redis replication group identifier. | `string` | n/a | yes |
| `region` | AWS region for dashboard metrics. | `string` | n/a | yes |
| `target_group_arn_suffix` | Target group ARN suffix. | `string` | n/a | yes |
| `ecs_service_names` | ECS service names to chart. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| `dashboard_name` | CloudWatch dashboard name. |
<!-- END_TF_DOCS -->
