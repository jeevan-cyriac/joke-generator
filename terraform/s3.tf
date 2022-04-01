resource "aws_s3_bucket" "website" {
  bucket = local.domain_name

  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.website.id

  policy = data.aws_iam_policy_document.s3_policy.json
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.website.arn}/*"]
    effect    = "Allow"

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.main.iam_arn]
    }
  }

  statement {
    sid       = "AllowSSLRequestsOnly"
    actions   = ["s3:*"]
    effect    = "Deny"
    resources = [aws_s3_bucket.website.arn, "${aws_s3_bucket.website.arn}/*"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    condition {
      test     = "Bool"
      values   = ["false"]
      variable = "aws:SecureTransport"
    }
  }
}
