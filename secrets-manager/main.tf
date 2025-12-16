# Define the Secret in Secrets Manager
resource "aws_secretsmanager_secret" "db_credentials" {
  name = "prod/db/credentials"
  description = "RDS database credentials for production"
}

# Dynamic Password Generation
resource "random_password" "db_password" {
    length = 16
    special = true
    override_special = "!@#$%&*"
  
}

# Store the Secret Value (username & password)]
resource "aws_secretsmanager_secret_version" "db_credentials_value" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = "master"
    password = random_password.db_password.result
  })
}
