provider "aws" {
  region = "eu-west-2"
}

variable "ssh_port" {
  description = "The port the server will use for ssh requests"
  default = "22"
}
variable "my_login" {
  type = string
  default = "ibartlam"
}

data "aws_availability_zones" "eu-west-2a" {}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}



resource "aws_instance" "ian_dev" {
#  ami = "ami-0c3f128b7298d29b9"
  ami = "${data.aws_ami.ubuntu.id}"
  instance_type = "t3.nano"
  key_name = "aws_london_keypair"
  user_data = "${file("userdata.sh")}"
  tags = {
    Name = "${var.my_login}-dev"
  }

  vpc_security_group_ids = ["${aws_security_group.ian_dev-sg.id}"]

}

resource "aws_security_group" "ian_dev-sg" {
  name = "${var.my_login}-sg"
  description = "${var.my_login}-sg"

  ingress {
    from_port = "${var.ssh_port}"
    to_port = "${var.ssh_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#output "ian_dev-sg_ip" {
#  value = "${aws_instance.ian_dev-sg.public_ip}"
#}

