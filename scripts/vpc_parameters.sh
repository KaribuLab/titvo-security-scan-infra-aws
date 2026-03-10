#!/bin/bash
set -e
cwd=$(cd .. && pwd)
source ./utils.sh
dotenv $cwd/.env
if [ -z "$VPC_ID" ];
then
 echo "VPC_ID variable not set"
 exit 1
fi
if [ -z "$SUBNET_ID" ];
then
 echo "SUBNET_ID variable not set"
 exit 1
fi
aws ssm put-parameter --name "/tvo/security-scan/prod/infra/vpc-id" --type "String" --value "$VPC_ID" --region us-east-1 --overwrite
aws ssm put-parameter --name "/tvo/security-scan/prod/infra/vpc/vpc_id" --type "String" --value "$VPC_ID" --region us-east-1 --overwrite
aws ssm put-parameter --name "/tvo/security-scan/prod/infra/subnet1" --type "String" --value "$SUBNET_ID" --region us-east-1 --overwrite
