locals {
  ecs_cpu_metrics = flatten([
    for service_name in var.ecs_service_names : [
      ["AWS/ECS", "CPUUtilization", "ClusterName", var.ecs_cluster_name, "ServiceName", service_name],
      ["AWS/ECS", "MemoryUtilization", "ClusterName", var.ecs_cluster_name, "ServiceName", service_name]
    ]
  ])
}
