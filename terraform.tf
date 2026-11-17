terraform {
  required_version = ">= 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {

    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
}




resource "aws_instance" "single_web_server" {

  ami                    = "ami-096ef200a877f36af"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
    #!/bin/bash
    mkdir -p /var/www && cd /var/www
    echo "Hello, World" > index.html
    nohup python3 -m http.server 8080 &
    EOF

  user_data_replace_on_change = true


  tags = {
    Name = "single-web-server"
  }

}
