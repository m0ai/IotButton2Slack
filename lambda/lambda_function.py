import os
import json 
import requests


def lambda_handler(event, context):
    clickType=event['clickType']
    message = os.getenv('{}_CLICK'format(clickType))
    r = send_notify(message)
    return json.dumps(r.text)
    

def send_notify_to_slack(message):
    INCOMING_URL = os.getenv('INCOMING_URL')
    r = requests.post(INCOMING_URL, json={'text' : message})
    return r