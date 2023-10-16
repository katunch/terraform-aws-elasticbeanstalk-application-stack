output "Jumphost_IP" {
  value = module.bastionhost.public_ip
}
output "Jumphost_Hostname" {
  value = module.bastionhost.public_dns
}

output "RDS_HOSTNAME" {
  value = module.database.rds_cluster_endpoint
}
output "RDS_HOSTNAME_READONLY" {
  value = module.database.rds_cluster_reader_endpoint
}
output "RDS_USERNAME" {
  value = module.database.rds_cluster_master_username
}
output "RDS_PASSWORD" {
  value     = module.database.rds_cluster_master_password
  sensitive = true
}
output "RDS_DB_NAME" {
  value = module.database.rds_cluster_database_name
}

output "s3_deployment_bucket_name" {
  value = module.elasticbeanstalk.deploymentBucketName
}
output "eb_cname" {
  value = module.elasticbeanstalk.eb_cname
}
output "eb_environmentId" {
  value = module.elasticbeanstalk.environmentId
}
output "eb_environmentName" {
  value = module.elasticbeanstalk.environmentName
}

output "AWS_KEY_ID" {
  value     = module.IAM.AWS_KEY_ID
  sensitive = true
}
output "AWS_SECRET_ACCESS_KEY" {
  value     = module.IAM.AWS_SECRET_ACCESS_KEY
  sensitive = true
}

output "opensearch_endpoint" {
  value = module.opensearch.opensearch_endpoint
}

output "opensearch_dashboard_endpoint" {
  value = module.opensearch.opensearch_dashboard_endpoint
}

output "opensearch_master_user" {
  value     = module.opensearch.opensearch_master_user
  sensitive = false
}

output "opensearch_master_password" {
  value     = module.opensearch.opensearch_master_password
  sensitive = true
}