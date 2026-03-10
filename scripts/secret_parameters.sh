#!/bin/bash
set -e
cwd=$(cd .. && pwd)
source ./utils.sh
dotenv $cwd/.env
if [ -z "$SECRET_KEY" ];
then
 echo "SECRET_KEY variable not set"
 exit 1
fi
if [ -z "$SECRET_NAME" ];
then
 echo "SECRET_NAME variable not set"
 exit 1
fi

if aws secretsmanager describe-secret --secret-id "$SECRET_NAME" --region us-east-1 >/dev/null 2>&1; then
 aws secretsmanager put-secret-value --secret-id "$SECRET_NAME" --secret-string "$SECRET_KEY" --region us-east-1 >/dev/null
else
 aws secretsmanager create-secret --name "$SECRET_NAME" --secret-string "$SECRET_KEY" --region us-east-1 >/dev/null
fi

SECRET_ARN=$(aws secretsmanager describe-secret --secret-id "$SECRET_NAME" --region us-east-1 | jq -r '.ARN')
echo "$SECRET_ARN"
aws ssm put-parameter --name "/tvo/security-scan/prod/infra/encryption-key-name" --type "String" --value "$SECRET_NAME" --region us-east-1 --overwrite
aws ssm put-parameter --name "/tvo/security-scan/prod/infra/secret-manager-arn" --type "String" --value "$SECRET_ARN" --region us-east-1 --overwrite
