## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| enable\_mode\_scan | Enable/Disable the mode 'scan' for PatchManager | `bool` | `false` | no |
| enable\_notification\_install | Enable/Disable the SNS notification for install patchs | `bool` | `false` | no |
| enable\_notification\_scan | Enable/Disable the SNS notification for scan | `bool` | `false` | no |
| environment | This label will be added after 'name' on all resources, and be added as the value for the 'Environment' tag where supported | `string` | n/a | yes |
| install\_maintenance\_window\_schedule | The schedule of the install Maintenance Window in the form of a cron or rate expression | `string` | `"cron(0 0 21 ? * WED *)"` | no |
| install\_maintenance\_windows\_targets | The map of tags for targetting which EC2 instances will be patched | <pre>list(object({<br>    key : string<br>    values : list(string)<br>    }<br>    )<br>  )</pre> | `[]` | no |
| install\_patch\_groups | The list of install patching groups, one target will be created per entry in this list. Update default value only if you know what you do | `list(string)` | <pre>[<br>  "TOPATCH"<br>]</pre> | no |
| maintenance\_window\_cutoff | The number of hours before the end of the Maintenance Window that Systems Manager stops scheduling new tasks for execution | `number` | `1` | no |
| maintenance\_window\_duration | The duration of the maintenence windows (hours) | `number` | `3` | no |
| max\_concurrency | The maximum amount of concurrent instances of a task that will be executed in parallel | `number` | `20` | no |
| max\_errors | The maximum amount of errors that instances of a task will tollerate before being de-scheduled | `number` | `50` | no |
| notification\_arn | The SNS ARN to use for notification | `string` | `""` | no |
| notification\_events | The list of different events for which you can receive notifications. Valid values: All, InProgress, Success, TimedOut, Cancelled, and Failed | `list(string)` | <pre>[<br>  "All"<br>]</pre> | no |
| notification\_type | When specified with Command, receive notification when the status of a command changes. When specified with Invocation, for commands sent to multiple instances, receive notification on a per-instance basis when the status of a command changes. Valid values: Command and Invocation | `string` | `"Command"` | no |
| reboot\_option | Parameter 'Reboot Option' to pass to the windows Task Execution. By Default : 'RebootIfNeeded'. Possible values : RebootIfNeeded, NoReboot | `string` | `"RebootIfNeeded"` | no |
| s3\_bucket\_name | The s3 bucket name where to store logs when patch are applied | `string` | n/a | yes |
| s3\_bucket\_prefix\_install\_logs | The directories where the logs of scan will be stored | `string` | `"install"` | no |
| s3\_bucket\_prefix\_scan\_logs | The directories where the logs of scan will be stored | `string` | `"scan"` | no |
| scan\_maintenance\_window\_schedule | The schedule of the scan Maintenance Window in the form of a cron or rate expression | `string` | `"cron(0 0 18 ? * WED *)"` | no |
| scan\_maintenance\_windows\_targets | The map of tags for targetting which EC2 instances will be scaned | <pre>list(object({<br>    key : string<br>    values : list(string)<br>    }<br>    )<br>  )</pre> | `[]` | no |
| scan\_patch\_groups | The list of scan patching groups, one target will be created per entry in this list. Update default value only if you know what you do | `list(string)` | <pre>[<br>  "TOSCAN"<br>]</pre> | no |
| service\_role\_arn | The sevice role ARN to attach to the Maintenance windows | `string` | n/a | yes |
| tags | a map of tags to put on resources | `map(string)` | `{}` | no |
| task\_install\_priority | Priority assigned to the install task. 1 is the highest priority. Default 1 | `number` | `1` | no |
| task\_scan\_priority | Priority assigned to the scan task. 1 is the highest priority. Default 1 | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| install\_maintenance\_windows\_id | The install maintenance windows Id |
| scan\_maintenance\_windows\_id | If scan enabled, the scan maintenance windows Id |

