
###
# Autoscaling policies
resource "aws_autoscaling_policy" "increase_by_one" {
  name                   = "${var.ecs_cluster_id}-increase-by-one"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = var.autoscaling_group_id
}

resource "aws_autoscaling_policy" "decrease_by_one" {
  name                   = "${var.ecs_cluster_id}-decrease-by-one"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = var.autoscaling_group_id
}

resource "aws_sns_topic" "interpreter" {
  name = format("%s-topic", var.autoscaling_group_id)
  tags = var.default_tags
}

resource "aws_sns_topic_subscription" "interpreter" {
  topic_arn = aws_sns_topic.interpreter.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.interpreter_draining.arn
}

resource "aws_lambda_permission" "interpreter" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.interpreter_draining.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.interpreter.arn
}

data "local_file" "index" {
  filename = "${path.module}/lambda/index.py"
}

data "archive_file" "interpreter_lambda" {
  type        = "zip"
  output_path = "interpreter_lambda.zip"

  source {
    content  = data.local_file.index.content
    filename = "index.js"
  }
}

resource "aws_lambda_function" "interpreter_draining" {
  function_name = format("%s-draining-function", var.prefix)
  role          = aws_iam_role.lambda.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.7"
  memory_size   = 128
  timeout       = 60

  environment {
    variables = {
      CLUSTER = var.ecs_cluster_id
      REGION  = data.aws_region.current.name
    }
  }
  tracing_config {
    mode = "Active"
  }
  filename         = data.archive_file.interpreter_lambda.output_path
  source_code_hash = data.archive_file.interpreter_lambda.output_base64sha256

  tags = var.default_tags
}

resource "aws_cloudwatch_log_group" "interpreter_draining" {
  name              = format("/aws/lambda/%s", aws_lambda_function.interpreter_draining.function_name)
  retention_in_days = 14

  tags = var.default_tags
}

resource "aws_autoscaling_lifecycle_hook" "interpreter_draining_hook" {
  name                    = format("%s-terminating-hook", var.prefix)
  autoscaling_group_name  = var.autoscaling_group_id
  default_result          = "ABANDON"
  heartbeat_timeout       = 900
  lifecycle_transition    = "autoscaling:EC2_INSTANCE_TERMINATING"
  notification_target_arn = aws_sns_topic.interpreter.arn
  role_arn                = aws_iam_role.lifecycle.arn
}
data "aws_caller_identity" "current" {}
/*
* Lambda IAM
*/
data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect = "Allow"
    actions = [
    "sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
      "lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda" {
  statement {
    effect = "Allow"
    actions = [
      "autoscaling:CompleteLifecycleAction",
    ]

    resources = [
      var.autoscaling_group_id
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      format("%s:*", aws_cloudwatch_log_group.interpreter_draining.arn)
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecs:ListContainerInstances",
      "ecs:DescribeContainerInstances",
      "ecs:UpdateContainerInstancesState",
    ]

    resources = [
      var.ecs_cluster_id,
      format("%s/*", var.ecs_cluster_arn),
      format("arn:aws:ecs:%s:%s:container-instance/%s/*", data.aws_region.current.name, data.aws_caller_identity.current.account_id, var.ecs_cluster_id)
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "sns:Publish",
    ]

    resources = [
      aws_sns_topic.interpreter.arn
    ]
  }
}

resource "aws_iam_role" "lambda" {
  name               = format("%s-draining-function-role", var.prefix)
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json

  tags = var.default_tags
}

resource "aws_iam_role_policy" "lambda_execution_policy" {
  name = format("%s-draining-function-policy", var.prefix)
  role = aws_iam_role.lambda.id

  policy = data.aws_iam_policy_document.lambda.json
}

data "aws_iam_policy_document" "lifecycle_assume_role" {
  statement {
    effect = "Allow"
    actions = [
    "sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
      "autoscaling.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lifecycle" {
  name               = format("%s-lifecycle-role", var.prefix)
  assume_role_policy = data.aws_iam_policy_document.lifecycle_assume_role.json

  tags = var.default_tags
}

data "aws_iam_policy_document" "lifecycle_policy" {
  statement {
    effect = "Allow"
    actions = [
      "sns:Publish",
    ]

    resources = [
      aws_sns_topic.interpreter.arn
    ]
  }
}

resource "aws_iam_role_policy" "lifecycle_execution_policy" {
  name = format("%s-lifecycle-policy", var.prefix)
  role = aws_iam_role.lifecycle.id

  policy = data.aws_iam_policy_document.lifecycle_policy.json
}