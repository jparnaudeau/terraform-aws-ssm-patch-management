# ssm-patch-management

This module is responsible of creating resources for automated applying patchs on your EC2 Instances.

You can define your own `patch baselines`. For doing that you need : 

* create a new `aws_ssm_patch_baseline`
* associated a value for the tag `Patch Group` that will be associated to the patch baseline.

AWS works as follows : 

* for an EC2 Instance, it determine the Operating System (by example Debian)
* If the default patch baseline for Debian is associated to the tag "Patch Group" = "TOPATCH", the EC2 Instance need to have a tag "Patch Group" = "TOPATCH" to be affected by the patching process.

Among the collection of EC2 instances that will meet these criteria, you can then target them more precisely by specifying a list of tags in the maintenance windows target. By example, if you specify the tag Team = "Data", the patching process will occurs on : Debian EC2 Instances that have the tag "Patch Group" = "TOPATCH" **and** the tag Team = "Data".

This module provides a way to create all AWS resources related to the PatchManagement :

## Patch Baseline Resources

* `aws_ssm_patch_baseline` : Patch BaseLine to apply to a specific operating system family. The approval rules defined into a patch baseline need to be setted when calling the module.


* `aws_ssm_patch_group` : When creating a patch baseline, you can associate it with a "patch group". Patch Group is only a tag `Patch Group` (beware of the space and the case) put on EC2 Instance.

Associated a Patch group to a patch Baseline, is the first step but it's not enough. You need to register as 'default' your patch baseline for your operating system.

The module handle a boolean `enable_mode_scan` that provides a way to only scan EC2 instances without patching. By default, this boolean is `false`. If you set to `true`, the module will :

* create the `aws_ssm_patch_baseline`
* Register the value (by default is "TOPATCH") for the tag "Patch Group" for patching instances.
* Register a second value (by default is "TOSCAN") for the tag Patch Group" for only scanning instances.

### Usage for Patch Baseline

you can find complete examples in `examples` directory.


```hcl

module "patch_baseline_amazonlinux2" {
  source = "../../patch_baseline"

  # tags parameters
  environment = var.environment

  # patch baseline parameters
  approved_patches_compliance_level = "HIGH"
  operating_system                  = local.operating_system_amazon_linux2
  description                       = "AmazonLinux2 - PatchBaseLine - Apply Critical Security Updates"
  tags                              = var.tags

  # define rules inside patch baseline
  patch_baseline_approval_rules = [
    {
      approve_after_days  = 7
      compliance_level    = "CRITICAL"
      enable_non_security = false
      patch_baseline_filters = [
        {
          name   = "PRODUCT"
          values = ["AmazonLinux2", "AmazonLinux2.0"]
        },
        {
          name   = "CLASSIFICATION"
          values = ["Security"]
        },
        {
          name   = "SEVERITY"
          values = ["Critical"]
        }
      ]
    }
  ]

  # parameters for scan : associated patch_group "scan" to this patch baseline
  enable_mode_scan = true
}

# register as default patch baseline our patch baseline
module "register_patch_baseline_amazonlinux2" {
  source = "../../register_default_patch_baseline"

  set_default_patch_baseline = true
  patch_baseline_id          = module.patch_baseline_amazonlinux2.patch_baseline_id
  operating_system           = local.operating_system_amazon_linux2
}

```


## Maintenance Windows Resources

* `aws_ssm_maintenance_window` : Maintenance Windows is the resource that permit to apply patches on your EC2 Instances, according to the patch baseline that you have defined. In addition to define maintenance windows's parameters, you need to define a "maintenance_windows_target" for targeting the EC2 Instances (EC2 Instances need to be in the PatchGroup associated to the PatchBaseline but can be more granular) and you need to define a "maintenance_windows_task" based on the SSM Document `AWS-RunPatchBaseline`.

* `aws_ssm_maintenance_window_target` : Define which EC2 Instances are targeted by the maintenance windows task. For targetting yours instances, use the variable `install_maintenance_windows_targets` : if you do not set this variable, by default, the target will be EC2 Instances that have the tag `Patch Group` = "TOPATCH".

* `aws_ssm_maintenance_window_task` : The task associated to the maintenance windows for patching EC2 Instance. Each execution produces logs and stores theses logs in a s3 bucket that you need to create before calling the module.



### Usage

you can find complete examples in `examples` directory.

```hcl

module "ssm-patch-management" {
  source = "../../maintenance_windows"

  # tags parameters
  environment = var.environment

  # global parameters
  s3_bucket_name   = aws_s3_bucket.ssm_patch_log_bucket.id
  service_role_arn = aws_iam_role.ssm_maintenance_window.arn

  # parameters for scan without patching ec2 instances
  enable_mode_scan                 = true
  scan_maintenance_window_schedule = "cron(0 0 8 ? * * *)"
  s3_bucket_prefix_scan_logs       = format("scan/%s", var.ssm_patch_logs_prefix)

  # parameters for installing patches on ec2 instances
  install_maintenance_window_schedule = "cron(0 0 20 ? * SUN *)"
  s3_bucket_prefix_install_logs       = format("install/%s", var.ssm_patch_logs_prefix)
  
  # limit the patching process to only ec2 Instances that have the tag "PatchGroup" = "TOPATCH" and "App" = "myapp" and "Critical" = "no"
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

if variable `enable_mode_scan` is true : the module create for you 3 additional resources :

* `aws_ssm_maintenance_window` : A second maintenance_windows resources is created. This maintenance windows scans the EC2 instances but does not install patches.

* `aws_ssm_maintenance_window_task` : The task associated to the maintenance windows for scanning EC2 Instance. Each execution produces logs and stores theses logs in a s3 bucket that you need to create before calling the module.

* `aws_ssm_maintenance_window_target` : The target associated to the maintenance windows for scanning EC2 instance. For targetting yours instances, you have the variable `scan_maintenance_windows_targets` : if you do not set this variable, by default, the target will be EC2 Instances that have the tag `Patch Group` = "TOSCAN". You can target a smaller set of instances by setting this variable.

## EC2 Instances - Prerequirements

for patching an EC2 Instance, you need to attach specific policies on the EC2 Instance role : 

* **AmazonEC2RoleforSSM**
* **AmazonSSMMaintenanceWindowRole**
* for sending patch logs on a centralized bucket, you need to attach this policy to the role of your EC2 Instances : 

```hcl

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ],
            "Resource": "arn:aws:s3:::your-centralized-patch-logs-bucket"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:PutObjectAcl"
            ],
            "Resource": "arn:aws:s3:::your-centralized-patch-logs-bucket/*"
        }
    ]
}

```


### :warning: Important note:

We highly recommand you using **explicitly a version tag of this module** instead of branch reference since the latter is changing frequently. (use **ref=v1.0.0**,  don't use **ref=master**)    

All the examples are available in `examples` subdirectory of this module.

## Inputs & outputs

you could find all Inputs & outputs of each submodule here :

### maintenance_windows

[docs](https://github.com/jparnaudeau/terraform-aws-ssm-patch-management/tree/master/maintenance_windows/README.md)

### patch_baseline

[docs](https://github.com/jparnaudeau/terraform-aws-ssm-patch-management/tree/master/patch_baseline/README.md)

### register_default_patch_baseline

[docs](https://github.com/jparnaudeau/terraform-aws-ssm-patch-management/tree/master/register_default_patch_baseline/README.md)

