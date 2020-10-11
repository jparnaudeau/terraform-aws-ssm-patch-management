terraform {
  required_version = "~> 0.12.9"
  required_providers {
    aws = "~> 2.30"
  }
}

###############
# Create SNS Topic
# for patchManagement Notification
###############
resource "aws_sns_topic" "ssm_patch_sns" {
  name = "sns-${var.environment}-patch-notifs"
}

###############
# Create Centralized S3 bucket logs
###############
resource "aws_s3_bucket" "ssm_patch_log_bucket" {
  bucket = "s3-${var.environment}-ssm-patch-logs-bucket"
  acl    = "private"

  tags = merge({Name = "s3-${var.environment}-ssm-patch-logs-bucket"}, var.tags)
}

###############
# Create Custom Role for patchManagement
# and attach AmazonSSMMaintenanceWindowRole policy to the role
###############
resource "aws_iam_role" "ssm_maintenance_window" {
  name = "role-${var.environment}-ssm-mw-role"
  path = "/system/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["ec2.amazonaws.com","ssm.amazonaws.com"]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "role_attach_ssm_mw" {
  role       = aws_iam_role.ssm_maintenance_window.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonSSMMaintenanceWindowRole"
}


###############
# Create PatchManagement Maintenance Windows
###############
module "ssm-patch-management" {
  source = "../../maintenance_windows"

  # tags parameters
  environment = var.environment

  # global parameters
  s3_bucket_name   = aws_s3_bucket.ssm_patch_log_bucket.id
  service_role_arn = aws_iam_role.ssm_maintenance_window.arn

  # parameters for scan
  enable_mode_scan                 = true
  scan_maintenance_window_schedule = "cron(0 0 17 ? * SUN *)"
  s3_bucket_prefix_scan_logs       = format("scan/%s", var.ssm_patch_logs_prefix)
  # By default, maintenance_windows_targets use the tag "Patch Group" = var.scan_patch_groups
  # scan_maintenance_windows_targets = [
  #   {
  #   key    = "tag:XXXX"
  #   values = ["someValues"]
  #   }
  # ]

  # parameters for install
  install_maintenance_window_schedule = "cron(0 0 20 ? * SUN *)"
  s3_bucket_prefix_install_logs       = format("install/%s", var.ssm_patch_logs_prefix)
  install_maintenance_windows_targets = [
    {
      key    = "tag:App"
      values = ["myapp"]
    },
    {
      key    = "tag:Critical"
      values = ["no"]
    }
  ]

  # enable SNS notification for install
  enable_notification_install = true
  notification_arn            = aws_sns_topic.ssm_patch_sns.arn
  notification_events         = ["Success", "Failed"] # Valid values: All, InProgress, Success, TimedOut, Cancelled, and Failed

}
