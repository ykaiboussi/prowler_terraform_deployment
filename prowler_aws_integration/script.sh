#!/bin/bash
echo "Running Prowler Scans"
./prowler -b -n -f us-east-1 -g cislevel1 -M csv -F prowler_report

echo "Converting Prowler Report from CSV to JSON"
python converter.py

echo "Loading JSON data into DynamoDB"
python loader.py