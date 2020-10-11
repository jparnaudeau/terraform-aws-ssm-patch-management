## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| null | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| approved\_patches | The list of approved patches for the SSM baseline | `list(string)` | `[]` | no |
| approved\_patches\_compliance\_level | Defines the compliance level for approved patches. This means that if an approved patch is reported as missing, this is the severity of the compliance violation. Valid compliance levels include the following: CRITICAL, HIGH, MEDIUM, LOW, INFORMATIONAL, UNSPECIFIED. The default value is UNSPECIFIED. | `string` | `"UNSPECIFIED"` | no |
| description | Desscription of the Patch Baseline | `string` | n/a | yes |
| enable\_mode\_scan | Enable/Disable the mode 'scan' for PatchManager | `bool` | `false` | no |
| environment | This label will be added after 'name' on all resources, and be added as the value for the 'Environment' tag where supported | `string` | n/a | yes |
| install\_patch\_groups | The list of install patching groups, one target will be created per entry in this list. Update default value only if you know what you do | `list(string)` | <pre>[<br>  "TOPATCH"<br>]</pre> | no |
| operating\_system | Defines the operating system the patch baseline applies to. Supported operating systems include WINDOWS, AMAZON\_LINUX, AMAZON\_LINUX\_2, SUSE, UBUNTU, CENTOS, and REDHAT\_ENTERPRISE\_LINUX. | `string` | n/a | yes |
| patch\_baseline\_approval\_rules | list of approval rules defined in the patch baseline (Max 10 rules). For compliance\_level, it means that if an approved patch is reported as missing, this is the severity of the compliance violation. Valid compliance levels include the following: CRITICAL, HIGH, MEDIUM, LOW, INFORMATIONAL, UNSPECIFIED. The default value is UNSPECIFIED. | <pre>list(object({<br>    approve_after_days : number<br>    compliance_level : string<br>    enable_non_security : bool<br>    patch_baseline_filters : list(object({<br>      name : string<br>      values : list(string)<br>    }))<br>  }))</pre> | <pre>[<br>  {<br>    "approve_after_days": 7,<br>    "compliance_level": "UNSPECIFIED",<br>    "enable_non_security": false,<br>    "patch_baseline_filters": [<br>      {<br>        "name": "PRODUCT",<br>        "values": [<br>          "WindowsServer2016",<br>          "WindowsServer2012R2"<br>        ]<br>      },<br>      {<br>        "name": "CLASSIFICATION",<br>        "values": [<br>          "CriticalUpdates",<br>          "SecurityUpdates"<br>        ]<br>      },<br>      {<br>        "name": "MSRC_SEVERITY",<br>        "values": [<br>          "Critical",<br>          "Important"<br>        ]<br>      }<br>    ]<br>  }<br>]</pre> | no |
| patch\_baseline\_label | This label will be added after 'envname' on all resources | `string` | `"ssmpbl"` | no |
| rejected\_patches | The list of rejected patches for the SSM baseline | `list(string)` | `[]` | no |
| scan\_patch\_groups | The list of scan patching groups, one target will be created per entry in this list. Update default value only if you know what you do | `list(string)` | <pre>[<br>  "TOSCAN"<br>]</pre> | no |
| tags | map of tags to associated on patch\_baseline | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| patch\_baseline\_id | Patch Baseline Id |

