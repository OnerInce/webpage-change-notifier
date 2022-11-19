dynamodb_table_name  = "WebPage"
lambda_function_name = "webpage-scrape-dynamo-stream" # must match with SAM template
sns_topic_name       = "webpages-updates-topic"       # must match with SAM template
email_address        = "example@example.com"