terraform {
    backend "s3" {
        bucket  = "robobakery-terraform-state"
        key     = "environments/dev/infra"
        region  = "ap-northeast-2"
    }
}
