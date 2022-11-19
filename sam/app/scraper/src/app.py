import json
import boto3
import os
import requests
from datetime import datetime


table = boto3.resource('dynamodb').Table(os.environ["TABLE_NAME"])


def lambda_handler(event, context): 
    try:
        r = requests.get(os.environ["PAGE_URL"])
        page_source = str(r.content)
    except Exception as e:
        print(e)
        raise e

    table.update_item(
    Key              = {'WebSite': os.environ["PAGE_URL"]},
    UpdateExpression = "set PageSource = :r",
    ExpressionAttributeValues={
        ':r': page_source,
    },
  )

    response = {
        'statusCode': 200,
        'body': 'successfully created item',
        'headers': {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
        },
    }

    return json.dumps(response)
