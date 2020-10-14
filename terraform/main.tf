provider "aws" {
  region  = "ap-northeast-2"
}

terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}


module "simple-iot-button-to-slack" {
  source = "https://github.com/m0ai/IotButton2Slack//modules/simple-iot-button-to-slack"

  slack_incomming_hook_url = "YOUR_INCOMMING_WEBHOOK_URL"

  lambda = {
    function_name = "iot_button_2_slack_notification"
    filename = "../lambda.zip"
    handler=  "lambda_function.lambda_handler"
    runtime = "python3.8"
  }

  message = {
    single_click = "Single Click"
    double_click = "Double Click"
    long_click   = "Long Click"
  }
}
