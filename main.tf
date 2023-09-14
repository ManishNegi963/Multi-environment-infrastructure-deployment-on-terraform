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
