variable "dynamodb_table_name" {
  type        = string
  description = "DynamoDB Table name to be created"
}

variable "lambda_function_name" {
  type        = string
  description = "AWS Lambda Notifier Function name which is created by SAM"
}

variable "sns_topic_name" {
  type        = string
  description = "SNS Topic Name to forward Webpage Changes as Notifications"
}

variable "email_address" {
  type        = string
  description = "Email Address to receive SNS Notifications"
}
