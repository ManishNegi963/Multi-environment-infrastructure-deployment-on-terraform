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
