variable "region" {
  default = "us-east-1"
}

provider "aws" {
  profile    = "lamudi-testing"
  region     = var.region
}

terraform {
  required_version = "0.12.8"
}

module "consul" {
  source      = "hashicorp/consul/aws"
  num_servers = "3"
}
