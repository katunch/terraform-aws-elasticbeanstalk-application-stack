output "AWS_KEY_ID" {
  value = aws_iam_access_key.deploymentAccessKey.id
}
output "AWS_SECRET_ACCESS_KEY" {
  value = aws_iam_access_key.deploymentAccessKey.secret
}