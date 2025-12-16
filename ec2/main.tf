# Provisioning EC2 to host python api
resource "aws_instance" "dev_proj_1_ec2" {
    ami = var.ami_id
    instance_type = var.ami_id
    key_name = "aws_key"
    subnet_id = var.subnet_id
    vpc_security_group_ids = [var.sg_enable_ssh_https, var.ec2_sg_name_for_python_api]
    associate_public_ip_address = var.enable_public_ip_address
    user_data = var.user_data_install_apache

    tags = {
      Name = var.tag_name
    }

    metadata_options {
      http_endpoint = "enabled"
      http_tokens = "required"
    }
}

# Attach key-pair
resource "aws_key_pair" "dev_proj_1_public_key" {
    key_name = "aws_key"
    public_key = var.public_key
  
}