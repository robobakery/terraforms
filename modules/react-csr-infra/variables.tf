provider "aws" {}
provider "aws" {
    alias = "virginia"
}

variable "AWS_REGION" {}

variable "root_domain_name" {}
variable "application_subdomain" {}
