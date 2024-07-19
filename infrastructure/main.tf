provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "securitygroup" {
  name        = "securitygroup"
  description = "Allow HTTP access"

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9443
    to_port     = 9443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 60000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "keypair" {
  key_name   = "terraform-keypair"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "server" {
  ami                    = "ami-0b72821e2f351e396"
  instance_type          = "t2.nano"
  user_data              = file("../scripts/user_data.sh")
  key_name               = aws_key_pair.keypair.key_name
  vpc_security_group_ids = [aws_security_group.securitygroup.id]
}
