locals {
  operating_system_debian = "DEBIAN"
}

#####
# Create Patch Baselines for Debian
#####
module "patch_baseline_debian" {
  source = "../../patch_baseline"

  # tags parameters
  environment = var.environment

  # patch baseline parameters
  approved_patches_compliance_level = "CRITICAL"
  operating_system                  = local.operating_system_debian
  description                       = "Debian - PatchBaseLine - Apply Critical Security Updates"
  tags                              = var.tags

  # define rules inside patch baseline
  # aws ssm describe-patch-properties --operating-system DEBIAN --property PRODUCT
  patch_baseline_approval_rules = [
    {
      approve_after_days  = 7
      compliance_level    = "CRITICAL"
      enable_non_security = false
      patch_baseline_filters = [
        {
          name   = "PRODUCT"
          values = ["Debian8", "Debian9"]
        },
        {
          name   = "PRIORITY"
          values = ["Required", "Important"]
        }
      ]
    }
  ]

  # parameters for scan : associated patch_group "scan" to this patch baseline
  enable_mode_scan = true
}

# register as default patch baseline our patch baseline
module "register_patch_baseline_debian" {
  source = "../../register_default_patch_baseline"

  set_default_patch_baseline = true
  patch_baseline_id          = module.patch_baseline_debian.patch_baseline_id
  operating_system           = local.operating_system_debian
}
