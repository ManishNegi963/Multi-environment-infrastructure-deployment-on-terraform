resource "aws_instance" "my-demo-instance" {
                count = 2
                ami = var.ami_id
                instance_type = var.instance_type
                tags = {
                        Name = "${var.env_name}_${var.instance_name}"
        }
}
