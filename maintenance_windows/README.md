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
