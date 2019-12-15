# Terraform for modern web application infrastructure

## Milestones
- [*] React CSR Infra
- [] Auto-scaling Server Infra using docker image

## Project Goal
### React CSR Infra
- S3
- CloudFront
- Route53 Record

### Auto-scaling Server Infra (using docker image)
- AWS Secret Manager
- ECR
- VPC
- Security Group
- ALB
- RDS
- IAM
- ECS

## Prerequisites
### AWS
- Create IAM User
- Create Route53 Hosted Zone (NS Configuration Required)
- Create ACM for hosted zone
- Create S3 Bucket for saving state of Terraform
- Create Environment Variable Keys in AWS Secret Manager
- Create ECR for saving docker containers

### CLI Tools
- Install AWS CLI
- Install Terraform CLI

### AWS Profile Configuration
```
$ aws configure
```

### Add Secrets
Add terraform.tfvars to each environment. (See example below)
```
# Add environment specific variable values to this file,
# can also optionally over-ride defaults is desired

# REQUIRED, AWS CREDENTIALS
AWS_ACCESS_KEY = "..."
AWS_SECRET_KEY = "..."
AWS_REGION     = "ap-northeast-2"

# REQUIRED, ENVIRONMENT SPECIFIC
root_domain_name        = "dev.your-domain.com" # or "your-domain.com"
application_subdomain   = "admin.dev.your-domain.com" # or "admin.your-domain.com"

# OPTIONAL, default overrides
# nothing to override as of yet.
```

## How to Apply
```
$ cd environments/dev
$ terraform init -backend-config="profile=profile_name"

$ terraform plan

$ terraform apply
```
