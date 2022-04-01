module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 2.0"

  domain_name = local.domain_name
  zone_id     = data.aws_route53_zone.domain.id
}
