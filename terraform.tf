provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "single_web_server" {

  ami           = "ami-096ef200a877f36af"
  instance_type = "t3.micro"

  tags = {
    Name = "single-web-server"
  }

}
