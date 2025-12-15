# Security Group For HTTP and SSH
resource "aws_security_group" "ec2_sg_ssh_http" {
    name = var.ec2_sg_name
    description = "Enable port 22(SSH) and port 80(HTTP)"
    vpc_id = var.vpc_id

    # SSH For Terraform Remote Exec
    ingress {
        description = "Allo remote SSH from anywhere"
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 22
        to_port = 22
        protocol = "tcp"
    }

    # HTTP
    ingress {
        description = "Allow HTTP request from anywhere"
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 80
        to_port = 80
        protocol = "tcp"
    }

    # HTTPS
    ingress {
        description = "Allow HTTPS request from anywhere"
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 443
        to_port = 443
        protocol = "tcp"
    }

    # Outgoing traffic over the internet
    egress {
        description = "Allow internet traffic-outgoing"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "SG to allow ssh & http/s"
    }
  
}

# Security group for jenkins 
resource "aws_security_group" "ec2_jenkins_port_8080" {
  name = var.ec2_jenkins_sg_name
  description = "Enable the port 8080 for jenkins"
  vpc_id = var.vpc_id

  ingress {
    description = "Allow 8080 port to access jenkins"
    from_port = 8080
    to_port = 8080
    cidr_blocks = ["0.0.0.0.0"]
    protocol = "tcp"
  }

  tags = {
    Name = "SG to allow port 8080"
  }
}