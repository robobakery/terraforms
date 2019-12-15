variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {}

variable "root_domain_name" {}
variable "application_subdomain" {}

provider "aws" {
    access_key  = "${var.AWS_ACCESS_KEY}"
    secret_key  = "${var.AWS_SECRET_KEY}"
    region      = "${var.AWS_REGION}"
}

# Alias for SSL Certificate cause it only supports us-east-1 region.
provider "aws" {
    alias   = "virginia"
    access_key  = "${var.AWS_ACCESS_KEY}"
    secret_key  = "${var.AWS_SECRET_KEY}"
    region  = "us-east-1"
}

module "react-csr-infra" {
    source = "../../modules/react-csr-infra"

    providers = {
        aws             = "aws"
        aws.virginia    = "aws.virginia"
    }

    AWS_REGION            = "${var.AWS_REGION}"
    root_domain_name      = "${var.root_domain_name}"
    application_subdomain = "${var.application_subdomain}"
}
