variable "slack_incomming_hook_url" {
  type = string
}


variable "lambda" {
  type = object({
    function_name = string
    filename = string
    handler = string
    runtime = string
  })
}

variable "message" {
  type = object({
    single_click =  string
    double_click = string
    long_click   = string
  })
}
