output "opensearch_endpoint" {
  value = aws_opensearch_domain.customers.endpoint
}

output "opensearch_dashboard_endpoint" {
  value = aws_opensearch_domain.customers.dashboard_endpoint
}

output "opensearch_master_user" {
  value     = var.opensearch_master_user
  sensitive = false
}

output "opensearch_master_password" {
  value     = random_string.opensearch-master-password.result
  sensitive = true
}