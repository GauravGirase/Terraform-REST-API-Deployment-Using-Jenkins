# EC2 instance for jenkins
resource "aws_instance" "jenkins_server" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = "aws_ec2_terraform"
    subnet_id = var.subnet_id
    vpc_security_group_ids = var.sg_for_jenkins
    associate_public_ip_address = var.enable_public_ip_address
    user_data = var.user_data_install_jenkins

    metadata_options {
      http_endpoint = "enabled"
      http_tokens = "required"
    }

    tags = {
        Name = var.tag_name
    }
}   

resource "aws_key_pair" "jenkins_server_public_key" {
  key_name = "aws_ec2_terraform"
  public_key = var.public_key
}
