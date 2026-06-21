resource "aws_iam_role" "this" {
  name               = "${var.name}-canary"
  assume_role_policy = data.aws_iam_policy_document.assume.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "basic" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "canary" {
  name   = "${var.name}-canary"
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.canary.json
}

resource "aws_synthetics_canary" "this" {
  name                 = var.name
  artifact_s3_location = var.artifact_s3_location
  execution_role_arn   = aws_iam_role.this.arn
  handler              = "index.handler"
  zip_file             = var.zip_file_path
  runtime_version      = var.runtime_version
  start_canary         = true

  schedule {
    expression = var.schedule_expression
  }

  run_config {
    timeout_in_seconds = 60
  }

  success_retention_period = 7
  failure_retention_period = 14

  dynamic "vpc_config" {
    for_each = length(var.subnet_ids) == 0 ? [] : [1]

    content {
      subnet_ids         = var.subnet_ids
      security_group_ids = var.security_group_ids
    }
  }

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "failed" {
  count = var.alarm_topic_arn == null ? 0 : 1

  alarm_name          = "${var.name}-canary-failed"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "Failed"
  namespace           = "CloudWatchSynthetics"
  period              = 300
  statistic           = "Sum"
  threshold           = 0
  alarm_description   = "Synthetic canary failed."
  alarm_actions       = [var.alarm_topic_arn]
  ok_actions          = [var.alarm_topic_arn]
  treat_missing_data  = "breaching"

  dimensions = {
    CanaryName = aws_synthetics_canary.this.name
  }

  tags = var.tags
}
