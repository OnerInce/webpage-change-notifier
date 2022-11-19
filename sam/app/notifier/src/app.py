import logging
import json
import boto3


client = boto3.client('sns')


def lambda_handler(event, context):
    aws_account_id = context.invoked_function_arn.split(":")[4]
    aws_region = context.invoked_function_arn.split(":")[3]
    sns_arn = f"arn:aws:sns:{aws_region}:{aws_account_id}:webpages-updates-topic"

    response = client.publish (
        TargetArn = sns_arn,
        Message = json.dumps({'default': "Your page has a change!"}),
        MessageStructure = 'json'
    )

    return {
      'statusCode': 200,
      'body': json.dumps(response)
   }