resource "aws_cloudwatch_log_group" "main" {
  name = var.applicationName
}

data "aws_iam_policy_document" "opensearch" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["es.amazonaws.com"]
    }

    actions = [
      "logs:PutLogEvents",
      "logs:PutLogEventsBatch",
      "logs:CreateLogStream",
    ]

    resources = ["arn:aws:logs:*"]
  }
}

resource "aws_cloudwatch_log_resource_policy" "opensearch" {
  policy_name     = "${var.applicationName}-iam-policy"
  policy_document = data.aws_iam_policy_document.opensearch.json
}

data "aws_subnets" "main" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_vpc" "main" {
  id = var.vpc_id
}

resource "aws_security_group" "default" {
  name        = "${var.applicationName}-opensearch-${var.domain}-sg"
  description = "Managed by Terraform"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = [
      data.aws_vpc.main.cidr_block,
    ]
  }
}

resource "aws_iam_service_linked_role" "default" {
  aws_service_name = "opensearchservice.amazonaws.com"
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "os-vpc-access" {
  statement {
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["es:*"]
    resources = ["arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.domain}/*"]
  }
}

resource "random_string" "opensearch-master-password" {
  length  = 16
  special = true
}

resource "aws_opensearch_domain" "customers" {
  domain_name    = var.domain
  engine_version = var.opensearch_engine_version

  cluster_config {
    instance_type  = var.instance_type
    instance_count = var.instance_count
  }
  ebs_options {
    ebs_enabled = true
    volume_size = var.eb_storage_size
    volume_type = var.eb_storage_type
  }

  log_publishing_options {
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.main.arn
    log_type                 = "INDEX_SLOW_LOGS"
  }

  vpc_options {
    subnet_ids         = [data.aws_subnets.main.ids[0]]
    security_group_ids = [aws_security_group.default.id]
  }

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
  }


  advanced_security_options {
    enabled                        = false
    anonymous_auth_enabled         = true
    internal_user_database_enabled = true
    master_user_options {
      master_user_name     = var.opensearch_master_user
      master_user_password = random_string.opensearch-master-password.result
    }
  }
  access_policies = data.aws_iam_policy_document.os-vpc-access.json

  encrypt_at_rest {
    enabled = true
  }

  domain_endpoint_options {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }
  node_to_node_encryption {
    enabled = true
  }

  depends_on = [aws_iam_service_linked_role.default]
}