# ssm-patch-management

This module is responsible of creating resources for automated applying patchs on your EC2 Instances.

This module provides a way to create the following resources:

## Patch Baselines Resources

* `aws_ssm_patch_baseline` : Patch BaseLine to apply to a specific operating system family. The approval rules defined into a patch baseline need to be setted when calling the module


* `aws_ssm_patch_group` : When creating a patch baseline, you can associate it with a "patch group". Patch Group is only a tag `Patch Group` (beware of the space and the case) put on EC2 Instance.

Associated a Patch group to a patch Baseline, is the first step but it's not enough.

The module handle a boolean `enable_mode_scan` that provides a way to only scan EC2 instances without patching. By default, this boolean is `false`

## Maintenance Windows Resources

* `aws_ssm_maintenance_window` for installing patches : Maintenance Windows is the resources that permit to patch EC2 Instances. In addition to define maintenance windows 's parameters, you need to define a "maintenance_windows_target" for targeting the EC2 Instances (EC2 Instances need to be in the PatchGroup associated to the PathBaseline but can be more granular) and you need to define a "maintenance_windows_task" based on the SSM Document `AWS-RunPatchBaseline`.

* `aws_ssm_maintenance_window_task` for installing patches: The task associated to the maintenance windows for patching EC2 Instance. Each execution produces logs and stores theses logs in a s3 bucket that you need to create before calling the module.

* `aws_ssm_maintenance_window_target` for installing patches : The target associated to the maintenance windows for patching EC2 instance. For targetting yours instances, you have the variable `install_maintenance_windows_targets` : if you does not set this variable, by default, the target will be EC2 Instances that have the tag `Patch Group` = "TOPATCH". You can target a smaller instance population by setting this variable like :

```
  install_maintenance_windows_targets = [
    {
      key    = "tag:XXXX"
      values = ["someValue"]
    },
    {
      key    = "tag:YYY"
      values = ["someValue"]
    }
  ]

```

if variable `enable_mode_scan` is true : 

* `aws_ssm_maintenance_window` for only scanning EC2 instances : a second maintenance_windows resources is created. This maintenance windows scans the EC2 instances but does not install patches.

* `aws_ssm_maintenance_window_task` for scanning EC2 instances : The task associated to the maintenance windows for scanning EC2 Instance. Each execution produces logs and stores theses logs in a s3 bucket that you need to create before calling the module.

* `aws_ssm_maintenance_window_target` for scanning patches : The target associated to the maintenance windows for scanning EC2 instance. For targetting yours instances, you have the variable `scan_maintenance_windows_targets` : if you does not set this variable, by default, the target will be EC2 Instances that have the tag `Patch Group` = "TOSCAN". You can target a smaller instance population by setting this variable.

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

## Usage

### :warning: Important note:

We highly recommand you using **explicitly a version tag of this module** instead of branch reference since the latter is changing frequently. (use **ref=v1.0.0**,  don't use **ref=master**)    

All the examples are available in `examples` subdirectory of this module.

## Inputs & outputs

you could find all Inputs & outputs of each submodule here :

### maintenance_windows

[docs](maintenance_windows/README.md)

### patch_baseline

[docs](patch_baseline/README.md)

### register_default_patch_baseline

[docs](register_default_patch_baseline/README.md)

