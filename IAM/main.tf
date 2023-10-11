resource "aws_iam_policy" "s3" {
  name        = "${var.applicationName}-s3-deploy-policy"
  path        = "/${var.applicationName}/"
  description = "Allows deployment of ${var.applicationName} to Elastic Beanstalk"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "VisualEditor0",
          "Effect" : "Allow",
          "Action" : [
            "s3:GetLifecycleConfiguration",
            "s3:GetBucketTagging",
            "s3:GetInventoryConfiguration",
            "s3:GetObjectVersionTagging",
            "s3:ListBucketVersions",
            "s3:GetBucketLogging",
            "s3:ListBucket",
            "s3:GetAccelerateConfiguration",
            "s3:GetObjectVersionAttributes",
            "s3:GetBucketPolicy",
            "s3:GetObjectVersionTorrent",
            "s3:GetObjectAcl",
            "s3:GetEncryptionConfiguration",
            "s3:GetBucketObjectLockConfiguration",
            "s3:GetIntelligentTieringConfiguration",
            "s3:GetBucketRequestPayment",
            "s3:GetObjectVersionAcl",
            "s3:GetObjectTagging",
            "s3:GetMetricsConfiguration",
            "s3:GetBucketOwnershipControls",
            "s3:GetBucketPublicAccessBlock",
            "s3:GetBucketPolicyStatus",
            "s3:ListBucketMultipartUploads",
            "s3:GetObjectRetention",
            "s3:GetBucketWebsite",
            "s3:GetObjectAttributes",
            "s3:GetBucketVersioning",
            "s3:GetBucketAcl",
            "s3:GetObjectLegalHold",
            "s3:GetBucketNotification",
            "s3:GetReplicationConfiguration",
            "s3:ListMultipartUploadParts",
            "s3:PutObject",
            "s3:GetObject",
            "s3:GetObjectTorrent",
            "s3:GetBucketCORS",
            "s3:GetAnalyticsConfiguration",
            "s3:GetObjectVersionForReplication",
            "s3:GetBucketLocation",
            "s3:GetObjectVersion"
          ],
          "Resource" : [
            "arn:aws:s3:::${var.s3_deployment_bucket_name}}",
            "arn:aws:s3:::${var.s3_deployment_bucket_name}/*"
          ]
        },
        {
          "Sid" : "VisualEditor1",
          "Effect" : "Allow",
          "Action" : [
            "s3:ListStorageLensConfigurations",
            "s3:ListAccessPointsForObjectLambda",
            "s3:GetAccessPoint",
            "s3:GetAccountPublicAccessBlock",
            "s3:ListAllMyBuckets",
            "s3:ListAccessPoints",
            "s3:ListJobs",
            "s3:ListMultiRegionAccessPoints"
          ],
          "Resource" : "*"
        }
      ]
    }
  )
}

resource "aws_iam_group" "deployers" {
  name = "${var.applicationName}-deployers"
  path = "/${var.applicationName}/"
}

resource "aws_iam_group_policy_attachment" "beanstalkAdmin" {
  group = aws_iam_group.deployers.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess-AWSElasticBeanstalk"
}

resource "aws_iam_group_policy_attachment" "S3DeployPolicy" {
  group      = aws_iam_group.deployers.name
  policy_arn = aws_iam_policy.s3.arn
}

resource "aws_iam_user" "deployer" {
  name = "${var.applicationName}-deployer"
  path = "/${var.applicationName}/"
}

resource "aws_iam_user_group_membership" "deployerGroupMembership" {
  user   = aws_iam_user.deployer.name
  groups = [aws_iam_group.deployers.name]
}

resource "aws_iam_access_key" "deploymentAccessKey" {
  user = aws_iam_user.deployer.name
}