terraform {
    backend "s3" {
        bucket  = "robobakery-terraform-state"
        key     = "environments/prod/infra"
        region  = "ap-northeast-2"
    }
}
