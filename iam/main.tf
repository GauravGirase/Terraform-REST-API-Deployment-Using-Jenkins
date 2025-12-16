# Create IAM Role For EC2. This allows EC2 service to assume the role.
resource "aws_iam_role" "ec2_role" {
    name = "ec2-ssm-read-role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Effect = "Allow"
            Principal = {
                Service = "ec2.amazonaws.com"
            }
            Action = "sts:AssumeRole"
        }]
    })
  
}

# Create IAM Policy (Permissions)
resource "aws_iam_policy" "ssm_read" {
  name = "ec2-ssm-read"
  description = "Allow EC2 to read DB config from SSM"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "ssm:GetParameter",
        "ssm:GetParameters",
        "ssm:GetParametersByPath"
      ]
      Resource = "arn:aws:ssm:*:*:parameter/prod/db/*"
    },
    {
      Effect = "Allow"
      Action = [
        "secretsmanager:GetSecretValue"
      ]
      Resource = "arn:aws:secretsmanager:*:*:secret:prod/db/credentials*"
    }]
  })
}

# Attach Policy to Role
resource "aws_iam_role_policy_attachment" "attach_ssm_policy" {
  role = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ssm_read.arn

}

# Create Instance Profile (REQUIRED for EC2)
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-ssm-read-profile"
  role = aws_iam_role.ec2_role.name
}
