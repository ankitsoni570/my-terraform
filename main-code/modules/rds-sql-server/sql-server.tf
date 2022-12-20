resource "aws_db_instance" "sqlserver" {
  identifier             = var.sql_server_name 
  instance_class         = var.sql_instance_class
  allocated_storage      = var.sql_allocated_size
  max_allocated_storage  = var.sql_max_allocated_size
  storage_type           = var.sql_storage_type
  engine                 = var.sql_engine
  engine_version         = var.sql_engine_ver
  username               = var.sql_db_user
  password               = var.sql_db_pass
  db_subnet_group_name   = aws_db_subnet_group.po-sql-subnet-grp.name
  vpc_security_group_ids = [aws_security_group.sql-server-sg.id]
  license_model          = "license-included"
#   parameter_group_name   = ""
  multi_az               = var.sql_multi_az
  publicly_accessible    = var.sql_accessibility
  skip_final_snapshot    = var.skip_final_snapshot
  auto_minor_version_upgrade = false
}

resource "aws_db_subnet_group" "po-sql-subnet-grp" {
  name       = var.sql_subnet_grp_name
  subnet_ids = var.pvt_subnet_id

  tags = {
    Name = "po-sql-subnet-group"
  }
}