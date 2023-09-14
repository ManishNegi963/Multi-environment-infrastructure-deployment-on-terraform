resource "aws_s3_bucket" "s3_bucket" {
        bucket = "${var.env_name}-${var.bucket_name}"
}
