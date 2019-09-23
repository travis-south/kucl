provider "aws" {
  profile    = "lamudi-testing"
  region     = "ap-southeast-1"
}

resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
}
