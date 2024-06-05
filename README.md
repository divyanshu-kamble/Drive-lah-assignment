This repository contains Terraform scripts and Python scripts for deploying an AWS infrastructure setup involving AWS Lambda, Amazon S3, and Amazon SQS. The infrastructure includes the creation of an S3 bucket, a Lambda function, an SQS queue, and a dead letter queue.

Features
1. AWS Services Deployment: Automates the provisioning of AWS infrastructure using Terraform.
2. Lambda Function with Python: Deploys a Lambda function written in Python to process incoming events.
3. S3 Bucket Creation: Creates an S3 bucket for storing JSON files.
4. SQS Queue Setup: Establishes an SQS queue to queue messages for processing.
5. Dead Letter Queue Configuration: Configures a dead letter queue to handle messages that couldn't be processed successfully.
6. Event-Driven Architecture: Triggers the Lambda function when a JSON file is added to the S3 bucket, which subsequently sends a message to the SQS queue and then, in case of failure, moves it to the dead letter queue.
