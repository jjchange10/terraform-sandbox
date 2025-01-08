provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "example" {
  ami = "ami-0ef29ab52ff72213b"
  instance_type = "t2.micro"
}