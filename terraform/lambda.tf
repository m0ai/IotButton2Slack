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

resource "aws_lambda_function" "test_lambda" {
  filename      = "../lambda.zip"
  function_name = "IotButton2SlackNotifter"
  role          = "${aws_iam_role.iam_for_lambda.arn}"
  handler       = "lambda_function.lambda_handler"

  source_code_hash = "${filebase64sha256("../lambda.zip")}"

  runtime = "python3.6"

  environment {
    variables = {
      INCOMING_URL = local.slack_incoming_url
      SINGLE_CLICK = local.single_click_msg  
      DOUBLE_CLICK = local.double_click_msg
      LONG_CLICK   = local.long_click_msg
    }
  }
}