## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| null | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| operating\_system | operating system related to the patch baseline that we want to set default | `string` | n/a | yes |
| patch\_baseline\_id | Patch Baseline Id that we want to set default patch baseline | `string` | n/a | yes |
| set\_default\_patch\_baseline | If true, the command will be launched | `bool` | `false` | no |

## Outputs

No output.

