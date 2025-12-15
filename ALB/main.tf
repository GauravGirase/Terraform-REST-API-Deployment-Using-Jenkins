# Application load balancer
resource "aws_lb" "dev_proj_1_lb" {
    name = var.lb_name
    internal = var.is_external
    load_balancer_type = var.lb_type
    security_groups = [var.sg_enable_ssh_https]
    subnets = var.subnet_ids

    enable_deletion_protection = false

    tags = {
      Name = "alb"
    }
}

# Target group attachment
resource "aws_lb_target_group_attachment" "dev_proj_1_lb_target_group_attachment" {
  target_group_arn = var.lb_target_group_arn
  target_id = var.ec2_instance_id
  port = var.lb_target_group_attachment_port
}

# listens for incoming traffic on a port and forwards it to a target group.
resource "aws_lb_listener" "dev_proj_1_lb_listener" {
    load_balancer_arn = aws_lb.dev_proj_1_lb.arn
    port = var.lb_listner_port # 80 → HTTP
    protocol = var.lb_listner_protocol # HTTP

    default_action {
      type = var.lb_listner_default_action
      target_group_arn = var.lb_target_group_arn
    }
  
}

# HTTPS - 443
resource "aws_lb_listener" "dev_proj_1_lb_https_listener" {
    load_balancer_arn = aws_lb.dev_proj_1_lb.arn
    port = var.lb_https_listner_port # 80 → HTTP
    protocol = var.lb_https_listner_protocol # HTTP
    ssl_policy = "ELBSecurityPolicy-FS-1-2-Res-2019-08"
    certificate_arn   = var.dev_proj_1_acm_arn
    
    default_action {
      type = var.lb_listner_default_action
      target_group_arn = var.lb_target_group_arn
    }
  
}

