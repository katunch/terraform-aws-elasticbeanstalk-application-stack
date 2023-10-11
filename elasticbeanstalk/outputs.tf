output "eb_cname" {
  value = aws_elastic_beanstalk_environment.default.cname
}
output "environmentId" {
  value = aws_elastic_beanstalk_environment.default.id
}
output "environmentName" {
  value = aws_elastic_beanstalk_environment.default.name
}

output "environmentEndpointURL" {
  value = aws_elastic_beanstalk_environment.default.endpoint_url
}

output "applicationArn" {
  value = aws_elastic_beanstalk_application.default.arn
}

output "deploymentBucketName" {
  value = aws_s3_bucket.deploymentBucket.id
}