data "http" "ip" {
  url = "https://checkip.amazonaws.com/"
}

resource "aws_security_group" "bastionAccess" {
  vpc_id      = var.vpc_id
  name        = "${var.applicationName}-bastion-access"
  description = "Allow access to bastion host"
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${replace(data.http.ip.response_body, "\n", "")}/32"]
  }
  egress {
    description = "All traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "bastion" {
  ami           = "ami-0f5506a411a8dab18"
  instance_type = "t4g.nano"

  subnet_id                   = var.subnet_id
  security_groups             = [aws_security_group.bastionAccess.id]
  key_name                    = var.ssh_key_name
  associate_public_ip_address = true
  tags = {
    Name = "${var.applicationName}-bastion"
  }
}