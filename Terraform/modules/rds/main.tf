# Data Sources for SSM Parameters
data "aws_ssm_parameter" "db_instance_name" {
  name            = var.db_instance_name_path
  with_decryption = true
}

data "aws_ssm_parameter" "master_username" {
  name            = var.master_username_path
  with_decryption = true
}

data "aws_ssm_parameter" "db_password" {
  name            = var.db_password_path
  with_decryption = true
}
resource "aws_db_instance" "db" {
  identifier              = data.aws_ssm_parameter.db_instance_name.value
  allocated_storage       = var.allocated_storage
  max_allocated_storage   = 20
  db_name                 = var.db_name
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t3.micro"
  username                = data.aws_ssm_parameter.master_username.value
  password                = data.aws_ssm_parameter.db_password.value
  parameter_group_name    = "default.mysql5.7"
  skip_final_snapshot     = true
  tags                    = var.tags_rds
  vpc_security_group_ids  = var.vpc_security_group_ids
  db_subnet_group_name    = var.subnet_group_name
  multi_az                = true
}


