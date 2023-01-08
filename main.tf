<<<<<<< HEAD
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.7"
    }
  }
  backend "s3" {
    bucket = "terraformstate2f7455"
    key    = "terraform.tfstate"
    region = "us-west-2"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
provider "aws" {
  region = "us-east-1"
  # access_key = ""
  # secret_key = ""
}

resource "aws_instance" "tfvm" {
  ami = "ami-0885b1f6bd170450c"
  instance_type = "t2.micro"
  # vpc_security_group_ids = [ aws_security_group.alexa.id ]
  security_groups = ["${aws_security_group.alexa.name}"]
  user_data = <<-EOF
                #!/bin/bash
                echo "You are inside a VM deployed by Alexa" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF
    tags = {
      Name = join("-",["alexa-aws-vm",tostring(timestamp())])
    }
}
resource "aws_security_group" "alexa" {
  name = join("-",["alexa-aws-sg",tostring(timestamp())])
=======
provider "aws" {
  region = "us-east-1"
  access_key = ""
  secret_key = ""
}
resource "aws_instance" "tfvm" {
  ami = "ami-0885b1f6bd170450c"
  instance_type = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.websg.id ]
  user_data = <<-EOF
                #!/bin/bash
                echo "I LOVE TERRAFORM" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF
    tags = {
      Name = "WEB-demo"
    }
}
resource "aws_security_group" "websg" {
  name = "web-sg01"
>>>>>>> 2c3f070 (test)
  ingress {
    protocol = "tcp"
    from_port = 8080
    to_port = 8080
    cidr_blocks = [ "0.0.0.0/0" ]
  }
<<<<<<< HEAD
  lifecycle {
    # Necessary if changing 'name' or 'name_prefix' properties.
    create_before_destroy = true
  }
=======
>>>>>>> 2c3f070 (test)
}
output "instance_ips" {
  value = aws_instance.tfvm.public_ip
}

<<<<<<< HEAD
#testing
=======
#testing
>>>>>>> 2c3f070 (test)
