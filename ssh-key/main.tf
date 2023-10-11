resource "aws_key_pair" "main" {
  key_name   = "${var.applicationName}-main-access-key"
  public_key = file("${var.public_key_path}")
  tags = {
    Name = "${var.applicationName} SSH access"
  }
}