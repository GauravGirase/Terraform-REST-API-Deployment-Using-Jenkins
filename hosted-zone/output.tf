
output "hosted_zone_id" {
  value = data.aws_route53_zone.dev_proj_1_domain.zone_id
}