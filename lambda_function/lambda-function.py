import json
import boto3
import urllib.parse
import os

session = boto3.Session()
s3 = session.client("s3")
sqs = session.client('sqs')
queue_url = os.environ['SQS_QUEUE_URL']

def lambda_handler(event, context):
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')

    try:
        response = s3.get_object(Bucket=bucket, Key=key)
        data = json.loads(response['Body'].read().decode('utf-8'))

        for user in data['users']:
            for msg in user['messages']:
                print(msg['content'])
                sqs.send_message(
                    QueueUrl=queue_url,
                    MessageBody=msg['content']
                )
        return {
            'statusCode': 200,
            'body': json.dumps('Messages sent to SQS successfully')
        }

    except Exception as e:
        print(e)
        print(f'Error getting object {key} from bucket {bucket}. Make sure they exist and your bucket is in the same region as this function.')
        raise e
