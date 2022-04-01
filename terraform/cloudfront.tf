resource "aws_cloudfront_origin_access_identity" "main" {
  comment = local.description
}

resource "aws_cloudfront_distribution" "main" {
  origin {
    domain_name = aws_s3_bucket.website.bucket_regional_domain_name
    origin_id   = "S3Origin"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.main.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    viewer_protocol_policy = "https-only"
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "S3Origin"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl     = 0
    default_ttl = 0
    max_ttl     = 0
  }


  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = module.acm.this_acm_certificate_arn
    ssl_support_method  = "sni-only"
  }


  custom_error_response {
    error_caching_min_ttl = "1"
    error_code            = "403"
    response_code         = "200"
    response_page_path    = "/index.html"
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  comment             = local.description
  aliases             = [local.domain_name]
  price_class         = "PriceClass_200"
}
