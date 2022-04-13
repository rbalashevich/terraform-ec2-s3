# terraform-ec2-s3: an exercise 

## What should be done
Using the IaC tool of your choice (CloudFormation, Terraform or cdk) write the code to create the following:
* A VPC with a private subnet and a public subnet (see here)
* An EC2 instance in private subnet based on ami-0a49b025fffbbdac6 (eu-central-1)
* Instance type should be configurable (with t3-micro being the default)

On the instance:
* install docker using user-data at instance launch
* Add an S3 bucket 
* Provide a role that will grant write access to the created bucket. The role should be attached to the instance created in (1)

Verify S3 access with write permissions by putting an object on s3 from the instance terminal.

## How to deal with S3 bucket from EC2 console:
* Do aws configure (the region is eu-central-1)
* aws s3 ls 
  aws s3 cp mascot.svg s3://my-bucket-35cf

## How to accomplish missed variables:
terraform plan -out terraform.out -var AWS_SECRET_KEY="..."

## Whom to thank? 
HashiCorp Learn Team, Anton Weiss & Sam Meech-Ward

