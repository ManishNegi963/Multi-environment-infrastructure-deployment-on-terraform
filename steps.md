# Step 1

- First, we will create the required providers in terraform.tf file.

      vim terraform.tf

  <img width="487" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/e4a47c76-8ee3-46d4-81a2-5785df2959ce">


      terraform init
  It will install the aws plugins specified in the terraform.tf file.

  <img width="602" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/b4e60641-d840-4c40-b8e6-7ded25e07e5d">

# Step 2

- Now, create providers.tf where we will configure the providers.

        vim providers.tf

  <img width="239" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/a0474403-1201-4d57-ac0f-b92c1559a23c">

# Step 3

- Let's create the template of the ec2 instance.

        vim ec2.tf

<img width="522" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/3c40a199-c9de-49bd-a4a4-323d369fea31">



      resource "aws_instance" "my-demo-instance" {
                      ami = ""
                      instance_type = ""
                      tags = {
                              Name = ""
              }
      }

  The values will come from variables.
  NOTE: In the tags, Name first initial must be a capital letter.

  # Step 4 

- Create variables.tf file.

        vim variables.tf

  <img width="557" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/fe3c8db6-5daf-49e6-a495-6cc520489526">

      variable "instance_type" {
              default = "t2.micro"
      }
      
      variable "instance_name" {
              default = "demo-instance"
      }
      
      variable "ami_id" {
              default = "ami-053b0d53c279acc90"
      }

  
Take the ami from ec2 instance.

# Step 5 

- Use the variables in ec2.tf

        resource "aws_instance" "my-demo-instance" {
                      ami = var.ami_id
                      instance_type = var.instance_type
                      tags = {
                              Name = var.instance_name
              }
      }

  - Now check by using the command terraform plan
 
          terraform plan
    
<img width="559" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/28fbf799-e886-42e7-b54d-ac0afa98c460">

The plan shows one instance will be created.

<img width="399" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/fb8ad8af-863d-48a5-88a2-38913cc793eb">

# Step 6

- Create s3 bucket.

        vim s3.tf
  
  <img width="419" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/f11a5fb3-d656-48e0-b065-5d1c7ad2fc1c">


      resource "aws_s3_bucket" "s3_bucket" {
              bucket = ""
      }

  Bucket names will come from variables.tf

# Step 7

- Create bucket variable in variables.tf file.

        variable "bucket_name" {
              default = "my-example-terra-project-bucket"
      }
  
  - Now use the above bucket name in s3.tf

             resource "aws_s3_bucket" "s3_bucket" {
                          bucket = var.bucket_name
                  }

   NOTE: It is good practice to use the command terraform plan after creating a new resource.

        terraform plan

  <img width="523" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/96ddd701-191e-4797-bb48-bb1911e89725">

Instance and s3 bucket will be created.

<img width="458" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/0b28492d-6487-46fb-9d02-c9b0d0420673">


# Step 8 

- Create dynamodb in file dynamodb.tf

        vim dynamodb.tf

  <img width="487" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/f640a06a-61ae-4421-a45b-bfc001d23508">

NOTE: 
hash_key is like the primary key

billing_mode will be as per usage.

type = "S" (S refers to string) (N refers to number)

attribute refers to column name

      resource "aws_dynamodb_table" "my-demo-table" {
              name =  ""
              billing_mode = "PAY_PER_REQUEST"
              hash_key = "emailID"
      
              attribute {
              name = "emailID"
              type = "S"
      }
      }

The value of the name will come from variables.tf file.

- Go to variables.tf and create a variable for the name of dynamodb.

  
      variable "table_name" {
              default = "demo-table"
      }

  - Now edit the dynamodb.tf to take name from variables.tf
 
         resource "aws_dynamodb_table" "my-demo-table" {
                    name =  var.table_name
                    billing_mode = "PAY_PER_REQUEST"
                    hash_key = "emailID"
            
                    attribute {
                    name = "emailID"
                    type = "S"
            }
            }
- Run command terraform plan

        terraform plan

<img width="575" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/91162ae5-d36f-48f9-ba53-f75ef577da3c">


  # Step 9

  - Now, in order to make 2 ec2 instances we have to initialize count =2 in ec2 resource.

          vim ec2.tf

    Add count = 2

             resource "aws_instance" "my-demo-instance" {
                            count = 2
                            ami = var.ami_id
                            instance_type = var.instance_type
                            tags = {
                                    Name = var.instance_name
                    }
            }

    Now, run the command terraform plan.

          terraform plan
    
<img width="467" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/6ac39bd2-37ab-424c-a12d-e4af231b83fb">

instance [0]

<img width="512" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/320d6142-3850-4c43-a79a-20981abfd7bb">

instance [1]

<img width="506" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/b96320f2-f999-4c9c-87fd-cd6ef1ab46f8">


# Step 10 Provision the infrastructure

- Run the command terraform apply

        terraform apply

  <img width="511" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/b406f6ab-f201-4194-9e9d-0c1b00dbecd2">

Two instances have been created.

<img width="605" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/14b9c1e1-391e-4a7d-b99a-a8c2a53270c8">

A bucket has been created.

<img width="605" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/ccfe032e-d9ed-4821-97f0-ab57f2b604c4">

A Dynamo db table has been created.

<img width="604" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/f0d44d50-8b13-44f9-9d4c-af5c21ccab75">

That means the template to create 2 ec2 instance and dynamodb table and s3 bucket is correct.

# Step 11 

- Destroy the infrastructure

        terraform destroy

  <img width="608" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/8cd0822a-4622-44d5-b69e-99d8b3ff1b38">

# Step 12 

- Now. we have to use the template to create infrastructure in Dev, QA, and Prod.

Let's make a folder for templates as modules and inside that create another folder as demo-app.

      mkdir modules 
      
      cd modules 
      
      mkdir demo-app 
      
      cd demo-app      

<img width="488" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/071fa26b-054c-4d42-aa61-ae112b401159">


- Now move the template inside the demo-app folder.

  NOTE: ../../ refrs to 2 directory backword.

        mv ../../dynamodb.tf .
      
        mv ../../ec2.tf .
      
        mv ../../variables.tf
      
        mv ../../s3.tf .
  These are part of modules.

  <img width="606" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/1d108c6a-36f7-4e6b-b00a-9b67c3c6acfb">

This is part of the root directory.

<img width="571" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/5b13a85a-02d4-4e65-9e55-6eefa9b7f72f">

NOTE: 

Now if we want to create different configuration in DEV as (t2.micro, Ubuntu) and (t2.small,Amazon Linux) in QA and (t2.medium,RHEL) in Prod, then this template won't be able to do it as it will create t2.micro, Ubuntu for all the 3 infrastructures as t2.micro<Ubuntu ami is written in variable file.

<img width="282" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/b40fdecf-3c72-4648-ba13-25b48915e4e3">

And, in order to resolve this, we won't use default values in variables.tf, we will only do variable declaration without variable initializing in varaibles.tf.

Now, the variables.tf will look like below:

      variable "instance_type" {
              type = string
              description ="This is instance type based on modules"
      }
      
      variable "instance_name" {
              description = "This ia instance name based on modules"
              type = string
      }
      
      variable "ami_id" {
              description = "This is AMI ID based on modules"
              type = string
      }
      
      variable "bucket_name" {
              type = string
      }
      
      variable "table_name" {
              type = string
      }

      variable "env_name" {
               type = string
      }

We will create a variable to know the name of infrastructure as env_name.


# Step 13

- Create main.tf to create Dev, QA and Prod infrstructure.

        vim main.tf

  <img width="421" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/f41f0bf7-be68-4374-b82c-f81e80df8cf8">

Let's create module.

NOw, we want the name of the instance to be include env_name, and for that we have to include in ec2.tf, s3.tf,dynamodb.tf: "${var.env_name}-${var.instance_name} 
It will result in : Dev-Demo_instance

      resource "aws_instance" "my-demo-instance" {
                      count = 2
                      ami = var.ami_id
                      instance_type = var.instance_type
                      tags = {
                              Name = "${var.env_name}-${var.instance_name}"
              }
      }

s3.tf

      resource "aws_s3_bucket" "s3_bucket" {
              bucket = "${var.env_name}-${var.bucket_name}"
      }

dynamodb.tf

      resource "aws_dynamodb_table" "my-demo-table" {
              name =  "${var.env_name}_${var.table_name}"
              billing_mode = "PAY_PER_REQUEST"
              hash_key = "emailID"
      
              attribute {
              name = "emailID"
              type = "S"
      }
      }
      
Let's create main.tf
module is a block which allow you to create a infrastructure using the template.
source is the source of the template
ami_id id ubuntu in dev, amazon linux in QA and RHEL in prod.

      #dev infra
      
      module "dev-demo-app" {
              source = "./modules/demo-app"
              instance_type = "t2.micro"
              env_name = "dev"
              ami_id = "ami-053b0d53c279acc90"
              instance_name = "demo-instance"
              bucket_name = "my-example-terra-project-bucket"
              table_name = "demo-table"
      
      }
      
      
      
      #qa infra
      
      module "qa-demo-app" {
              source = "./modules/demo-app"
              instance_type = "t2.small"
              env_name = "qa"
              ami_id = "ami-04cb4ca688797756f"
              instance_name = "demo-instance"
              bucket_name = "my-example-terra-project-bucket"
              table_name = "demo-table"
      
      }
      
      
      
      #prod infra
      
      module "prod-demo-app" {
              source = "./modules/demo-app"
              instance_type = "t2.medium"
              env_name = "prod"
              ami_id = "ami-026ebd4cfe2c043b2"
              instance_name = "demo-instance"
              bucket_name = "my-example-terra-project-bucket"
              table_name = "demo-table"
      
      }

# Step 14

  - Run the command teeraform init to install the module.

            terraform init

<img width="588" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/ea0b0295-7768-4594-bf15-fba4f7801d70">

<img width="572" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/75b6d61f-3d6a-4fe4-9053-6e6785242c38">


# Step 15

- Check main.tf configuration

        terraform plan

  <img width="585" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/51f86905-7a1b-42c9-899a-6a66e13e9a69">

12 resoucres will be created. (6 ec2 instances in which 2 of Dev, QA, Prod and 3 S3 bucket of each and 3dynamo table of each) 

<img width="465" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/3c387474-892e-4381-91a6-d24c05c89b83">

- Apply the resources to create infrastructure.

        terraform apply

<img width="552" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/2af9baa2-9571-4b23-9fe5-eee560cdabb2">

12 resorces have been created.

<img width="482" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/ff05044a-169d-408a-b1f3-0fe9ee4441b6">

Created Instances.

<img width="604" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/5bbfae8e-a7b6-4492-b986-3ecfe9877251">

Created S3 bucket.

<img width="604" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/ae8b23e5-62b7-4c5d-869c-cf85c4eb38f7">

Created dynamodb table.

<img width="602" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/de22fcc9-a214-418b-ab3e-76a879b62d4f">


# Step 15

- If we want to create a particular module:

        terraform destroy -target=module.qa-demo-app

<img width="706" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/fb58a634-a2a3-436c-bc40-cf369d22ae3e">


- Destroy all the infrastructure.

        terraform destroy

  <img width="699" alt="image" src="https://github.com/ManishNegi963/Multi-environment-infrastructure-deployment-on-terraform/assets/124788172/9daaf6ad-523a-4a04-9a35-2de7da009a9c">
