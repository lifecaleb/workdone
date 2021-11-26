TERRAFORM NOTE
Terraform is an infrastructure as code tool that can be utilize to deploy infrastructure on different providers platform.
example of a providers are AWS, AZURE, GCP, DOCKER etc.
Terraform was created by Hashicorp and it runs on both HCL Hashicorp Configuration Language and JSON 
Terraform is Cloud agnostic or Vendor Neutral as it works with multiple providers. ****

Terraform is made up of some important files listed below
MAIN.TF: is the file that hold the resource code
PROVIDER.TF: This is the file that states the provider terraform is working with. 
            
VARIABLE.TF:This is the file that prevent hardcoding by variablizing key-values 
OUTPUT.TF: this file shows certian key information upon deployment of a terraform code
TERRAFORM_STATEFILE: This file store the terraform configuration 
BACKEND_FILE: This is use to store statefiles remotely and lock the statefile 

Terraform also applies an important concept call MODULARITY CONCEPT 
MODULARITY is the concept of reusing and backing up terraform files 

Common Terraform Commands
Terraform init: Prepare your working directory for other commands
                It downloads the provider and all neccessary plugins
Terraform validate: Check whether the configuration is valid and syntax error free
Terraform plan: Show changes required by the current configuration
Terraform apply:Create or update infrastructure
Terraform destroy:  Destroy previously-created infrastructure
Terraform show: Show the current state or a saved plan
Terraform import: Associate existing infrastructure with a Terraform resource
Terraform workspace: Workspace management
Terraform version: Show the current Terraform version
Terraform output: Show output values from your root module

TERRAFORM WITH AWS
Terraform is used to create resources on aws. example of resources are EC2, VPC, S3, RDS etc
 
 Prerequisite for Using Terraform on AWS:
1. AWS account with authorized user access
2. AWS CLI
3. Install Terraform on your computer or in an EC2 instance

Terraform code is written in block and each code block has a function to perform */

#CREATING
# TWO EC2 INSTANCES 
# ONE VPC

#                      MAIN.TF (ec2.tf)
  #BLOCK TYPE   BLOCK-LABEL1  BLOCK-LABEL2
 resource     "aws_instance"   "web1"            {
      #BODY OF THE CODE STARTS HERE
     instance_type = "t2.micro" 
     #ARGUMENT    +     ARGUMENT VALUE OR ATTRIBUTE OR EXPRESSION = A STRING 
     ami = "ami-04902260ca3d33422"
     count = 2
     
     
     tags = {
    Name = "Fitbitting_Amazon_linux"
  }
}
 
#                      MAIN.TF (ec2.tf)
  #            RESOURCE TYPE  RESOURCE NAME
 resource     "aws_instance"   "web2"            {
      #BODY OF THE CODE STARTS HERE
     instance_type = "t2.micro"
     ami = "ami-0b0af3577fe5e3532"
     
     
     tags = {
    Name = "Fitbitting_RedHat"
  }
}

#                      MAIN.TF(vpc.tf)
 resource "aws_vpc" "web_vpc" {
     cidr_block = var.vpc_cidr
 }


#                      PROVIDER.TF
 provider "aws" {
  region = "us-east-1"
 }

 #                      VARIABLE.TF
 variable "vpc_cidr" {
     default = "10.0.0.0/16"
     type = string
 }

 #                     OUTPUT.TF
 output "instance_ip_addr" {
  value = aws_instance.web2.private_ip
}