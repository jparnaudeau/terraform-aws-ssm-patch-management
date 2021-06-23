resource "aws_ssm_patch_baseline" "baseline" {

  name             = format("%s-%s-patch-baseline-%s", var.patch_baseline_label,var.environment, lower(var.operating_system))
  description      = var.description
  operating_system = var.operating_system

  approved_patches                  = var.approved_patches
  rejected_patches                  = var.rejected_patches
  approved_patches_compliance_level = var.approved_patches_compliance_level

  dynamic "approval_rule" {
    for_each = var.patch_baseline_approval_rules
    content {

      approve_after_days  = approval_rule.value.approve_after_days
      compliance_level    = approval_rule.value.compliance_level
      enable_non_security = approval_rule.value.enable_non_security

      # patch filter values : https://docs.aws.amazon.com/cli/latest/reference/ssm/describe-patch-properties.html
      dynamic "patch_filter" {
        for_each = approval_rule.value.patch_baseline_filters

        content {
          key    = patch_filter.value.name
          values = patch_filter.value.values
        }
      }
    }
  }
  tags = var.tags
}

# bug in terraform provider on aws_ssm_patch_group : can't associated the same patch group to a patch baseline. But it's not in accordance with the AWS Officials Docs
# need to use a null_resource instead
# https://github.com/terraform-providers/terraform-provider-aws/issues/9603
# Fixed in version 0.33 of the provider

resource "aws_ssm_patch_group" "install_patchgroup" {
  for_each = toset(var.install_patch_groups)
    baseline_id = aws_ssm_patch_baseline.baseline.id
    patch_group = each.key
}

# resource "null_resource" "register_patch_baseline_for_install_patch_group" {
#   count = length(var.install_patch_groups)

#   triggers = {
#     baseline_id               = aws_ssm_patch_baseline.baseline.id
#     install_patch_groups_list = join(",", var.install_patch_groups)
#   }

#   provisioner "local-exec" {
#     command = <<EOT
#       ${path.module}/register-patch-baseline-for-patch-group.sh ${self.triggers.baseline_id} ${self.triggers.install_patch_groups_list}
# EOT
#   }

#   provisioner "local-exec" {
#     when    = destroy
#     command = <<EOT
#       ${path.module}/deregister-patch-baseline-for-patch-group.sh ${self.triggers.baseline_id} ${self.triggers.install_patch_groups_list}
# EOT
#   }
# }


resource "aws_ssm_patch_group" "scan_patchgroup" {
  for_each = var.enable_mode_scan ? toset(var.scan_patch_groups) : []
    baseline_id = aws_ssm_patch_baseline.baseline.id
    patch_group = each.key
}

# bug in terraform provider on aws_ssm_patch_group : can't associated the same patch group to a patch baseline. 
# But it's not in accordance with the AWS Officials Docs.
# need to use a null_resource instead
# https://github.com/terraform-providers/terraform-provider-aws/issues/9603
# resource "null_resource" "register_patch_baseline_for_scan_patch_group" {
#   count = (var.enable_mode_scan ? 1 : 0) * length(var.scan_patch_groups)

#   triggers = {
#     baseline_id            = aws_ssm_patch_baseline.baseline.id
#     scan_patch_groups_list = join(",", var.scan_patch_groups)
#   }

#   provisioner "local-exec" {
#     command = <<EOT
#       ${path.module}/register-patch-baseline-for-patch-group.sh ${self.triggers.baseline_id} ${self.triggers.scan_patch_groups_list}
# EOT
#   }

#   provisioner "local-exec" {
#     when    = destroy
#     command = <<EOT
#       ${path.module}/deregister-patch-baseline-for-patch-group.sh ${self.triggers.baseline_id} ${self.triggers.scan_patch_groups_list}
# EOT
#   }
# }
