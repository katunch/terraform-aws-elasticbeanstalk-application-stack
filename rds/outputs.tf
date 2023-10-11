output "rds_cluster_master_username" {
  description = "The master username"
  value       = aws_rds_cluster.default.master_username
}

output "rds_cluster_master_password" {
  description = "Database master password"
  value       = aws_rds_cluster.default.master_password
  sensitive   = true
}

output "rds_cluster_endpoint" {
  description = "The RDS cluster writer endpoint"
  value       = aws_rds_cluster.default.endpoint
}

output "rds_cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = aws_rds_cluster.default.reader_endpoint
}

output "rds_cluster_database_name" {
  description = "The database name"
  value       = aws_rds_cluster.default.database_name
}