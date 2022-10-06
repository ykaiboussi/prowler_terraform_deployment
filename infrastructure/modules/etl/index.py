import json
import boto3
import datetime
import uuid
import os
def lambda_handler(event, context):
  # import Lambda ENV VARs
  accountId = os.environ['account_num']
  awsRegion = os.environ['region']
  # Use Prowler finding notes for ASFF Description
  prowlerDescription = str(event['CHECK_RISK'][0]['dynamodb']['NewImage']['CHECK_RISK']['S'])
  # Use Prowler finding title text for ASFF Title
  prowlerTitle = str(event['Records'][0]['dynamodb']['NewImage']['TITLE_TEXT']['S'])
  # looping through Prowler score result, set severity & compliance based on finding
  prowlerResult = str(event['Records'][0]['dynamodb']['NewImage']['CHECK_RESULT']['S'])
  if prowlerResult == 'PASS':
      prowlerComplianceRating = 'PASSED'
      prowlerProductSev = int(0)
      prowlerProductNorm = int(0)
  elif prowlerResult == 'INFO':
      prowlerComplianceRating = 'NOT_AVAILABLE'
      prowlerProductSev = int(1)
      prowlerProductNorm = int(1)
  elif prowlerResult == 'FAIL':
      prowlerComplianceRating = 'FAILED'
      prowlerProductSev = int(8)
      prowlerProductNorm = int(80)
  else:
      print("No Compliance Info Found!")
  # ISO Time
  iso8061Time = datetime.datetime.utcnow().replace(tzinfo=datetime.timezone.utc).isoformat()
  # ASFF BIF Id
  asffID = str(uuid.uuid4())
  # import security hub boto3 client
  sechub = boto3.client('securityhub')
  # call BIF
  try:
      response = sechub.batch_import_findings(
          Findings=[
              {
                  'SchemaVersion': '2018-10-08',
                  'Id': asffID,
                  'ProductArn': 'arn:aws:securityhub:' + awsRegion + ':' + accountId + ':product/' + accountId + '/default',
                  'ProductFields': {
                      'ProviderName': 'Prowler',
                      'ProviderVersion': 'v2.1.0',
                      },
                  'GeneratorId': asffID,
                  'AwsAccountId': accountId,
                  'Types': [ 'Software and Configuration Checks' ],
                  'FirstObservedAt': iso8061Time,
                  'UpdatedAt': iso8061Time,
                  'CreatedAt': iso8061Time,
                  'Severity': {
                      'Product': prowlerProductSev,
                      'Normalized': prowlerProductNorm
                  },
                  'Title': prowlerTitle,
                  'Description': prowlerDescription,
                  'Resources': [
                      {
                          'Type': 'AwsAccount',
                          'Id': 'AWS::::Account:' + accountId,
                          'Partition': 'aws',
                          'Region': awsRegion,
                      }
                  ],
                  'WorkflowState': 'NEW',
                  'Compliance': {'Status': prowlerComplianceRating},
                  'RecordState': 'ACTIVE'
              }
          ]
      )
      print(response)
  except Exception as e:
      print(e)
      print("Submitting finding to Security Hub failed, please troubleshoot further") 
      raise