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
