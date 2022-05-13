## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.15 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.15 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_maintenance_window.install_window](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window) | resource |
| [aws_ssm_maintenance_window.scan_window](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window) | resource |
| [aws_ssm_maintenance_window_target.target_install](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window_target) | resource |
| [aws_ssm_maintenance_window_target.target_scan](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window_target) | resource |
| [aws_ssm_maintenance_window_task.task_install_patches](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window_task) | resource |
| [aws_ssm_maintenance_window_task.task_scan_patches](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_maintenance_window_task) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_mode_scan"></a> [enable\_mode\_scan](#input\_enable\_mode\_scan) | Enable/Disable the mode 'scan' for PatchManager | `bool` | `false` | no |
| <a name="input_enable_notification_install"></a> [enable\_notification\_install](#input\_enable\_notification\_install) | Enable/Disable the SNS notification for install patchs | `bool` | `false` | no |
| <a name="input_enable_notification_scan"></a> [enable\_notification\_scan](#input\_enable\_notification\_scan) | Enable/Disable the SNS notification for scan | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | This label will be added after 'name' on all resources, and be added as the value for the 'Environment' tag where supported | `string` | n/a | yes |
| <a name="input_install_maintenance_window_schedule"></a> [install\_maintenance\_window\_schedule](#input\_install\_maintenance\_window\_schedule) | The schedule of the install Maintenance Window in the form of a cron or rate expression | `string` | `"cron(0 0 21 ? * WED *)"` | no |
| <a name="input_install_maintenance_windows_targets"></a> [install\_maintenance\_windows\_targets](#input\_install\_maintenance\_windows\_targets) | The map of tags for targetting which EC2 instances will be patched | <pre>list(object({<br>    key : string<br>    values : list(string)<br>    }<br>    )<br>  )</pre> | `[]` | no |
| <a name="input_install_patch_groups"></a> [install\_patch\_groups](#input\_install\_patch\_groups) | The list of install patching groups, one target will be created per entry in this list. Update default value only if you know what you do | `list(string)` | <pre>[<br>  "TOPATCH"<br>]</pre> | no |
| <a name="input_maintenance_window_cutoff"></a> [maintenance\_window\_cutoff](#input\_maintenance\_window\_cutoff) | The number of hours before the end of the Maintenance Window that Systems Manager stops scheduling new tasks for execution | `number` | `1` | no |
| <a name="input_maintenance_window_duration"></a> [maintenance\_window\_duration](#input\_maintenance\_window\_duration) | The duration of the maintenence windows (hours) | `number` | `3` | no |
| <a name="input_max_concurrency"></a> [max\_concurrency](#input\_max\_concurrency) | The maximum amount of concurrent instances of a task that will be executed in parallel | `number` | `20` | no |
| <a name="input_max_errors"></a> [max\_errors](#input\_max\_errors) | The maximum amount of errors that instances of a task will tollerate before being de-scheduled | `number` | `50` | no |
| <a name="input_notification_arn"></a> [notification\_arn](#input\_notification\_arn) | The SNS ARN to use for notification | `string` | `""` | no |
| <a name="input_notification_events"></a> [notification\_events](#input\_notification\_events) | The list of different events for which you can receive notifications. Valid values: All, InProgress, Success, TimedOut, Cancelled, and Failed | `list(string)` | <pre>[<br>  "All"<br>]</pre> | no |
| <a name="input_notification_type"></a> [notification\_type](#input\_notification\_type) | When specified with Command, receive notification when the status of a command changes. When specified with Invocation, for commands sent to multiple instances, receive notification on a per-instance basis when the status of a command changes. Valid values: Command and Invocation | `string` | `"Command"` | no |
| <a name="input_reboot_option"></a> [reboot\_option](#input\_reboot\_option) | Parameter 'Reboot Option' to pass to the windows Task Execution. By Default : 'RebootIfNeeded'. Possible values : RebootIfNeeded, NoReboot | `string` | `"RebootIfNeeded"` | no |
| <a name="input_role_arn_for_notification"></a> [role\_arn\_for\_notification](#input\_role\_arn\_for\_notification) | Role Used by SSM Service Role to trigger notification | `string` | `""` | no |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | The s3 bucket name where to store logs when patch are applied | `string` | n/a | yes |
| <a name="input_s3_bucket_prefix_install_logs"></a> [s3\_bucket\_prefix\_install\_logs](#input\_s3\_bucket\_prefix\_install\_logs) | The directories where the logs of scan will be stored | `string` | `"install"` | no |
| <a name="input_s3_bucket_prefix_scan_logs"></a> [s3\_bucket\_prefix\_scan\_logs](#input\_s3\_bucket\_prefix\_scan\_logs) | The directories where the logs of scan will be stored | `string` | `"scan"` | no |
| <a name="input_scan_maintenance_window_schedule"></a> [scan\_maintenance\_window\_schedule](#input\_scan\_maintenance\_window\_schedule) | The schedule of the scan Maintenance Window in the form of a cron or rate expression | `string` | `"cron(0 0 18 ? * WED *)"` | no |
| <a name="input_scan_maintenance_windows_targets"></a> [scan\_maintenance\_windows\_targets](#input\_scan\_maintenance\_windows\_targets) | The map of tags for targetting which EC2 instances will be scaned | <pre>list(object({<br>    key : string<br>    values : list(string)<br>    }<br>    )<br>  )</pre> | `[]` | no |
| <a name="input_scan_patch_groups"></a> [scan\_patch\_groups](#input\_scan\_patch\_groups) | The list of scan patching groups, one target will be created per entry in this list. Update default value only if you know what you do | `list(string)` | <pre>[<br>  "TOSCAN"<br>]</pre> | no |
| <a name="input_service_role_arn"></a> [service\_role\_arn](#input\_service\_role\_arn) | The sevice role ARN to attach to the Maintenance windows | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | a map of tags to put on resources | `map(string)` | `{}` | no |
| <a name="input_task_install_priority"></a> [task\_install\_priority](#input\_task\_install\_priority) | Priority assigned to the install task. 1 is the highest priority. Default 1 | `number` | `1` | no |
| <a name="input_task_scan_priority"></a> [task\_scan\_priority](#input\_task\_scan\_priority) | Priority assigned to the scan task. 1 is the highest priority. Default 1 | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_install_maintenance_windows_id"></a> [install\_maintenance\_windows\_id](#output\_install\_maintenance\_windows\_id) | The install maintenance windows Id |
| <a name="output_scan_maintenance_windows_id"></a> [scan\_maintenance\_windows\_id](#output\_scan\_maintenance\_windows\_id) | If scan enabled, the scan maintenance windows Id |
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.15 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.15 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_patch_baseline.baseline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_patch_baseline) | resource |
| [aws_ssm_patch_group.install_patchgroup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_patch_group) | resource |
| [aws_ssm_patch_group.scan_patchgroup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_patch_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_approved_patches"></a> [approved\_patches](#input\_approved\_patches) | The list of approved patches for the SSM baseline | `list(string)` | `[]` | no |
| <a name="input_approved_patches_compliance_level"></a> [approved\_patches\_compliance\_level](#input\_approved\_patches\_compliance\_level) | Defines the compliance level for approved patches. This means that if an approved patch is reported as missing, this is the severity of the compliance violation. Valid compliance levels include the following: CRITICAL, HIGH, MEDIUM, LOW, INFORMATIONAL, UNSPECIFIED. The default value is UNSPECIFIED. | `string` | `"UNSPECIFIED"` | no |
| <a name="input_description"></a> [description](#input\_description) | Desscription of the Patch Baseline | `string` | n/a | yes |
| <a name="input_enable_mode_scan"></a> [enable\_mode\_scan](#input\_enable\_mode\_scan) | Enable/Disable the mode 'scan' for PatchManager | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | This label will be added after 'name' on all resources, and be added as the value for the 'Environment' tag where supported | `string` | n/a | yes |
| <a name="input_install_patch_groups"></a> [install\_patch\_groups](#input\_install\_patch\_groups) | The list of install patching groups, one target will be created per entry in this list. Update default value only if you know what you do | `list(string)` | <pre>[<br>  "TOPATCH"<br>]</pre> | no |
| <a name="input_operating_system"></a> [operating\_system](#input\_operating\_system) | Defines the operating system the patch baseline applies to. Supported operating systems include WINDOWS, AMAZON\_LINUX, AMAZON\_LINUX\_2, SUSE, UBUNTU, CENTOS, and REDHAT\_ENTERPRISE\_LINUX. | `string` | n/a | yes |
| <a name="input_patch_baseline_approval_rules"></a> [patch\_baseline\_approval\_rules](#input\_patch\_baseline\_approval\_rules) | list of approval rules defined in the patch baseline (Max 10 rules). For compliance\_level, it means that if an approved patch is reported as missing, this is the severity of the compliance violation. Valid compliance levels include the following: CRITICAL, HIGH, MEDIUM, LOW, INFORMATIONAL, UNSPECIFIED. The default value is UNSPECIFIED. | <pre>list(object({<br>    approve_after_days : number<br>    compliance_level : string<br>    enable_non_security : bool<br>    patch_baseline_filters : list(object({<br>      name : string<br>      values : list(string)<br>    }))<br>  }))</pre> | <pre>[<br>  {<br>    "approve_after_days": 7,<br>    "compliance_level": "UNSPECIFIED",<br>    "enable_non_security": false,<br>    "patch_baseline_filters": [<br>      {<br>        "name": "PRODUCT",<br>        "values": [<br>          "WindowsServer2016",<br>          "WindowsServer2012R2"<br>        ]<br>      },<br>      {<br>        "name": "CLASSIFICATION",<br>        "values": [<br>          "CriticalUpdates",<br>          "SecurityUpdates"<br>        ]<br>      },<br>      {<br>        "name": "MSRC_SEVERITY",<br>        "values": [<br>          "Critical",<br>          "Important"<br>        ]<br>      }<br>    ]<br>  }<br>]</pre> | no |
| <a name="input_patch_baseline_label"></a> [patch\_baseline\_label](#input\_patch\_baseline\_label) | This label will be added after 'envname' on all resources | `string` | `"ssmpbl"` | no |
| <a name="input_rejected_patches"></a> [rejected\_patches](#input\_rejected\_patches) | The list of rejected patches for the SSM baseline | `list(string)` | `[]` | no |
| <a name="input_scan_patch_groups"></a> [scan\_patch\_groups](#input\_scan\_patch\_groups) | The list of scan patching groups, one target will be created per entry in this list. Update default value only if you know what you do | `list(string)` | <pre>[<br>  "TOSCAN"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | map of tags to associated on patch\_baseline | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_patch_baseline_id"></a> [patch\_baseline\_id](#output\_patch\_baseline\_id) | Patch Baseline Id |
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.15 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.register_default_patch_baseline](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_operating_system"></a> [operating\_system](#input\_operating\_system) | operating system related to the patch baseline that we want to set default | `string` | n/a | yes |
| <a name="input_patch_baseline_id"></a> [patch\_baseline\_id](#input\_patch\_baseline\_id) | Patch Baseline Id that we want to set default patch baseline | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS Region in which the register will be proceed | `string` | n/a | yes |
| <a name="input_set_default_patch_baseline"></a> [set\_default\_patch\_baseline](#input\_set\_default\_patch\_baseline) | If true, the command will be launched | `bool` | `false` | no |

## Outputs

No outputs.
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.14.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.2.2 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_file.baselineIds](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.baselineIds](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [local_file.baselineIds](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_baselineIds"></a> [baselineIds](#output\_baselineIds) | n/a |
