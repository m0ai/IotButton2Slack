#####################################
# Lambda Function Resources
#####################################

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "send_to_slack" {
  filename      = var.lambda.filename
  function_name = var.lambda.function_name
  handler       =  var.lambda.handler

  runtime = var.lambda.runtime
  role          = aws_iam_role.iam_for_lambda.arn
  source_code_hash = filebase64sha256(var.lambda.filename)

  environment {
    variables = {
      INCOMING_URL = var.slack_incomming_hook_url
      SINGLE_CLICK = var.message.single_click
      DOUBLE_CLICK = var.message.double_click
      LONG_CLICK   = var.message.long_click
    }
  }
}
