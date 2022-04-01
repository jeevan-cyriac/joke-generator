resource "aws_route53_record" "cloudfront" {
  name    = local.domain_name
  type    = "A"
  zone_id = data.aws_route53_zone.domain.id

  alias {
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = false
  }
}
