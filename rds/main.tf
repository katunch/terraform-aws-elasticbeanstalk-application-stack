resource "aws_security_group" "dbaccess" {
  name        = "${var.applicationName}-dbaccess-sg"
  description = "Allow access to RDS"
  vpc_id      = var.vpc_id

  ingress {
    description = "MySQL/Aurora"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_blocks
  }

  tags = {
    Name = "${var.applicationName}-dbaccess-sg"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "${var.applicationName}-db-subnet-group"
  subnet_ids = var.subnets[*]
  tags = {
    Name = "${var.applicationName}-db-subnet-group"
  }
}
resource "random_password" "master_password" {
  length  = 12
  special = false
}

resource "aws_rds_cluster" "default" {
  cluster_identifier      = "${var.applicationName}-rds-cluster"
  engine                  = var.db_engine
  engine_version          = var.db_engine_version
  availability_zones      = var.availability_zones
  database_name           = var.db_default_scheme
  master_username         = var.db_admin_username
  master_password         = random_password.master_password.result
  backup_retention_period = 5
  preferred_backup_window = "01:00-03:00"
  vpc_security_group_ids  = [aws_security_group.dbaccess.id]
  db_subnet_group_name    = aws_db_subnet_group.default.name
  skip_final_snapshot     = true
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "${var.applicationName}-rds-cluster-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.default.id
  instance_class     = var.db_instance_class
  engine             = aws_rds_cluster.default.engine
}