// Retrieve the certificate we generated on step 0
data "aws_acm_certificate" "ssl_cert" {
    provider    = "aws.virginia"
    domain      = "${var.root_domain_name}"
    statuses    = ["ISSUED"]
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "Origibn Access Identity for S3"
}

/**
    Defind CloudFront Distribution
    - It will use the SSL certificate
    - It will redirect all the http traffic to https
    - It will serve the content from S3 bucket: ${var.application_subdomain}
*/
resource "aws_cloudfront_distribution" "frontend_cloudfront_distribution" {
    depends_on = ["data.aws_acm_certificate.ssl_cert"]
    origin {
        domain_name = "${aws_s3_bucket.s3_bucket.bucket_regional_domain_name}"
        origin_id   = "S3-${var.application_subdomain}"

        s3_origin_config {
            origin_access_identity = "${aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path}"
        }
    }

    enabled             = true
    is_ipv6_enabled     = true
    default_root_object = "index.html"

    aliases = ["${var.application_subdomain}"]

    default_cache_behavior {
        viewer_protocol_policy  = "redirect-to-https"
        compress                = true
        allowed_methods         = ["GET", "HEAD"]
        cached_methods          = ["GET", "HEAD"]
        target_origin_id        = "S3-${var.application_subdomain}"
        min_ttl                 = 0
        default_ttl             = 86400
        max_ttl                 = 31536000

        forwarded_values {
            query_string = false

            cookies {
                forward = "none"
            }
        }
    }

    custom_error_response {
        error_caching_min_ttl   = 3000
        error_code              = 404
        response_code           = 200
        response_page_path      = "/index.html"
    }

    custom_error_response {
        error_caching_min_ttl   = 3000
        error_code              = 403
        response_code           = 200
        response_page_path      = "/index.html"
    }

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }

    viewer_certificate {
        acm_certificate_arn             = "${data.aws_acm_certificate.ssl_cert.arn}"
        cloudfront_default_certificate  = false
        minimum_protocol_version        = "TLSv1.2_2018"
        ssl_support_method              = "sni-only"
    }
}
