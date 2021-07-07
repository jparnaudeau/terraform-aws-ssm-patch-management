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
