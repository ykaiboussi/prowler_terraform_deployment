# Prowler Deployment
This IaC deployment of [prowler](https://github.com/prowler-cloud/prowler) and AWS Fargate to send security findings to Security Hub.

## Deployment
### Deploy Prowler Image to ECR
Steps to build prowler application image to upload ECR

#### Create application's repository
`cd infrastructure/repository`
`terraform apply`

#### Deployment to ECR 
Specifiy aws region and root ECR repository to authenticate AWS CLI to push docker image.

```
aws ecr get-login-password --region EDIT_ME_AWS_REGION | docker login --username AWS --password-stdin ROOT_ECR_REPO
```

#### Build & Deploy docker image to ECR
Steps to deploy application docker image to ECR repository

1. `cd prowler-aws-securityhub-integration && docker build -t prowler_app .` 
2. `docker tag IMAGE:latest ROOT_REPO/prowler_app:latest`
3. `docker push ROOT_REPO/prowler_app:latest`

#### Deploy ECS Service
Steps to deploy implementation to run prowler scans

1. `cd environment`
2. Update `terraform.tfvars` values
3. `terraform init && terraform apply`

## How to stop ECS Tasks:
1. `aws ecs update-service --cluster <cluster-name> --service <service-name> --desired-count x`

### Credits:
[Jonathan Rau's Whitepaper](https://aws.amazon.com/blogs/security/use-aws-fargate-prowler-send-security-configuration-findings-about-aws-services-security-hub/)

[appsecco](https://github.com/appsecco/prowler-aws-securityhub-integration)
