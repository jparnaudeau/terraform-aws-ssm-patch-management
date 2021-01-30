# maintenance windows

## example

```hcl

###############
# Create PatchManagement Maintenance Windows
# - one maintenance windows for scanning all ec2 Instances with tag "Patch Group" = "TOSCAN" every day at 08:00 CET
# - one maintenance windows for patching ec2 Instances with tag "Patch Group" = "TOPATCH" and "App" = "myapp" and "Critical" = "no", every sunday at 20:00 CET
###############
module "ssm-patch-management" {
  source = "github.com/jparnaudeau/terraform-aws-ssm-patch-management//maintenance_windows?ref=v1.0.0"
  

  # tags parameters
  environment = var.environment

  # global parameters
  s3_bucket_name   = aws_s3_bucket.ssm_patch_log_bucket.id
  service_role_arn = aws_iam_role.ssm_maintenance_window.arn

  # parameters for scan
  enable_mode_scan                 = true
  scan_maintenance_window_schedule = "cron(0 0 8 ? * * *)"
  s3_bucket_prefix_scan_logs       = format("scan/%s", var.ssm_patch_logs_prefix)

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


```
