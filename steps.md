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

- Let's create ec2.tf file to configure ec2 instances.

        vim ec2.tf

  
