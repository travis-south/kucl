variable "region" {
  default = "us-east-1"
}

provider "aws" {
  profile    = "lamudi-testing"
  region     = var.region
}

variable "amis" {
  type = "map"
  default = {
    "ap-southeast-1" = "ami-048a01c78f7bae4aa"
    "eu-west-1" = "ami-048a01c78f7bae4aa"
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "terraform-getting-started-guide-lamudi"
  acl    = "private"
}

resource "aws_instance" "example" {
  ami           = var.amis[var.region]
  instance_type = "t3.micro"
  depends_on = [aws_s3_bucket.example]
  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
}

resource "aws_eip" "ip" {
    vpc = true
    instance = aws_instance.example.id
}

resource "aws_instance" "another" {
  ami           = var.amis[var.region]
  instance_type = "t3.micro"
}

output "ip" {
  value = aws_eip.ip.public_ip
}
