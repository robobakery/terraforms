data "aws_iam_policy_document" "static_web" {
    statement {
        sid = "AllowPublicReadAccess"
        actions = ["s3:GetObject"]
        resources = ["arn:aws:s3:::${var.application_subdomain}/*"]
        principals {
            type        = "CanonicalUser"
            identifiers = ["${aws_cloudfront_origin_access_identity.origin_access_identity.s3_canonical_user_id}"]
        }
    }
}

resource "aws_s3_bucket" "s3_bucket" {
    region  = "${var.AWS_REGION}"

    bucket  = "${var.application_subdomain}"
    acl     = "public-read"
    policy  = "${data.aws_iam_policy_document.static_web.json}"

    website {
        index_document = "index.html"
        error_document = "index.html"
    }
}
