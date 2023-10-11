data "aws_iam_policy_document" "eb_role_assume_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2" {
  name               = "${var.applicationName}-ec2-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.eb_role_assume_policy.json
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.applicationName}-ec2-instance-profile"
  role = aws_iam_role.ec2.name
}


resource "aws_iam_policy_attachment" "beanstalk_ec2_worker" {
  name       = "${var.applicationName}-elastic-beanstalk-ec2-worker"
  roles      = ["${aws_iam_role.ec2.id}"]
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
}

resource "aws_iam_policy_attachment" "beanstalk_ec2_web" {
  name       = "${var.applicationName}-elastic-beanstalk-ec2-web"
  roles      = ["${aws_iam_role.ec2.id}"]
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_policy_attachment" "beanstalk_ec2_container" {
  name       = "${var.applicationName}-elastic-beanstalk-ec2-container"
  roles      = ["${aws_iam_role.ec2.id}"]
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
}