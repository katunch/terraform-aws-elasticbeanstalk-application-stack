terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.4.0"
    }
  }
  required_version = ">=1.2.0"
}
## ============= VPC =============
module "vpc" {
  source = "./vpc"

  applicationName      = var.applicationName
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  vpc_cidr_block       = var.vpc_cidr_block
}

## ============= SSH Key =============
module "ssh-key" {
  source          = "./ssh-key"
  applicationName = var.applicationName
  public_key_path = var.ssh_public_key_path
}

## ============= Bastion Host =============
module "bastionhost" {
  source = "./bastion-host"

  applicationName = var.applicationName
  vpc_id          = module.vpc.vpc_id
  subnet_id       = module.vpc.public_subnets[0]
  ssh_key_name    = module.ssh-key.key_name
}

## ============= Opensearch =============
module "opensearch" {
  source = "./opensearch"

  applicationName           = var.applicationName
  vpc_id                    = module.vpc.vpc_id
  opensearch_engine_version = var.opensearch_engine_version

}

## ============= RDS =============
module "database" {
  source = "./rds"

  applicationName     = var.applicationName
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = [module.vpc.cidr_block]
  availability_zones  = module.vpc.availability_zones
  subnets             = module.vpc.private_subnets
}

## ============= Elastic Beanstalk =============
module "elasticbeanstalk" {
  source = "./elasticbeanstalk"

  applicationName     = var.applicationName
  vpc_id              = module.vpc.vpc_id
  vpc_cidr_block      = module.vpc.cidr_block
  domain_name         = var.dns_name
  environment_name    = var.applicationEnvironment
  ssh_key_name        = module.ssh-key.key_name
  subnets             = module.vpc.public_subnets
  elb_subnets         = module.vpc.public_subnets
  ssl_cert_arn        = var.ssl_cert_arn
  solution_stack_name = var.eb_solution_stack_name
  instance_type       = var.eb_instance_type
  max_instance_count  = 2
  eb_settings = [{
    namespace = "aws:elasticbeanstalk:container:tomcat:jvmoptions"
    name      = "Xmx"
    value     = "256m"
  }]
  environment_variables = {
    RDS_HOSTNAME        = module.database.rds_cluster_endpoint
    RDS_USERNAME        = module.database.rds_cluster_master_username
    RDS_PASSWORD        = module.database.rds_cluster_master_password
    RDS_DB_NAME         = module.database.rds_cluster_database_name
    OPENSEARCH_HOSTNAME = "https://${module.opensearch.opensearch_endpoint}"
    OPENSEARCH_USERNAME = module.opensearch.opensearch_master_user
    OPENSEARCH_PASSWORD = module.opensearch.opensearch_master_password
  }

  depends_on = [module.database, module.opensearch]
}

## ============= IAM =============
module "IAM" {
  source                           = "./IAM"
  applicationName                  = var.applicationName
  elasticbeanstalk_application_arn = module.elasticbeanstalk.applicationArn
  s3_deployment_bucket_name        = module.elasticbeanstalk.deploymentBucketName

  depends_on = [module.elasticbeanstalk]
}
