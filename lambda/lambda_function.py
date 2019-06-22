import json
import requests

INCOMING_URL = os.getenv('INCOMING_URL')

def lambda_handler(event, context):
    r = requests.post( INCOMING_URL, json={'text' : 'test'})
    return json.dumps(r.text)





