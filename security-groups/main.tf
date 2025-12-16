# SG for ec2 instance to access over ssh and http/https
resource "aws_security_group" "ec2_sg_ssh_http" {
  name = var.ec2_sg_name
  description = "Enable ports 22 (ssh) % port 80"
  vpc_id = var.vpc_id

  # ssh 
  ingress {
    description = "Allow remote SSH from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }

  # HTTP
  ingress {
    description = "Allow HTTP request from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    to_port = 80
    from_port = 80
    protocol = "tcp"
  }

    # HTTP
    ingress {
        description = "Allow HTTPS request from anywhere"
        cidr_blocks = ["0.0.0.0/0"]
        to_port = 443
        from_port = 443
        protocol = "tcp"
    }

    # Outgoing traffic
    egress {
        description = "Allow outbound traffic over the internet"
        cidr_blocks = ["0.0.0.0/0"]
        to_port = 0
        from_port = 0
        protocol = "-1"
    }
}

# SG for RDS
resource "aws_security_group" "rds_mysql_sg" {
    name = "rds-sg"
    description = "Allow access to RDS from EC2 (web server)"
    vpc_id = var.vpc_id

    ingress {
        description = "Allow traffic on port 3306"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = var.public_subnet_cidr_block # where web server is up and running
    }
}

# SG for application (python api)
resource "aws_security_group" "ec2_sg_python_api" {
    name = var.ec2_sg_name_for_python_api
    description = "Enable the port 5000 for flask api"
    vpc_id = var.vpc_id

    ingress {
        description = "Allow traffic on port 5000"
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 5000
        to_port = 5000
        protocol = "tcp"
    }

    tags = {
      Name = "SG for backedn api on port 5000"
    }
  
}