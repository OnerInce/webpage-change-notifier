resource "aws_dynamodb_table" "webpage-table" {
  name           = var.dynamodb_table_name
  billing_mode   = "PROVISIONED"
  hash_key 		   = "WebSite"
  read_capacity  = 20
  write_capacity = 20

  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "WebSite"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-table-webpage-change-notifier"
    Environment = "production"
  }
}

data "aws_lambda_function" "existing" {
  function_name = var.lambda_function_name
}

resource "aws_lambda_event_source_mapping" "example" {
  event_source_arn  = aws_dynamodb_table.webpage-table.stream_arn
  function_name     = data.aws_lambda_function.existing.arn
  starting_position = "LATEST"
}

resource "aws_sns_topic" "webpage_updates" {
  name = var.sns_topic_name
}

resource "aws_sns_topic_subscription" "user_updates_email" {
  topic_arn = aws_sns_topic.webpage_updates.arn
  protocol  = "email"
  endpoint  = var.email_address
}
