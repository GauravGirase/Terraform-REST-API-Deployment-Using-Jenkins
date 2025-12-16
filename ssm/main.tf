resource "aws_ssm_parameter" "db_endpoint" {
  name  = "/prod/db/endpoint"
  type  = "String"
  value = var.rds_endpoint
}

resource "aws_ssm_parameter" "db_name" {
  name  = "/prod/db/name"
  type  = "String"
  value = var.db_name
}