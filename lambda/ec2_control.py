import boto3
import os

def lambda_handler(event, context):
    ec2 = boto3.client('ec2')
    instance_id = os.environ['INSTANCE_ID']
    action = event.get('action')
    if action == "start":
        ec2.start_instances(InstanceIds=[instance_id])
    elif action == "stop":
        ec2.stop_instances(InstanceIds=[instance_id])
    return {"status": "done"}