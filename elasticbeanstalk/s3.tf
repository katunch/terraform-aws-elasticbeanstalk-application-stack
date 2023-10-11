resource "aws_s3_bucket" "deploymentBucket" {
  bucket        = "${var.applicationName}-deployment-bucket"
  force_destroy = true
}