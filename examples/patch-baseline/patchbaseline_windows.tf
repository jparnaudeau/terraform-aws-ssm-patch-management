locals {
  operating_system_windows = "WINDOWS"
}

#####
# Create Patch Baselines for Windows
#####
module "patch_baseline_windows" {
  source = "../../patch_baseline"

  # tags parameters
  environment = var.environment

  # patch baseline parameters
  approved_patches_compliance_level = "HIGH"
  operating_system                  = local.operating_system_windows
  description                       = "Windows - PatchBaseLine - Apply Critical Security Updates"
  tags                              = var.tags

  # define rules inside patch baseline
  patch_baseline_approval_rules = [
    {
      approve_after_days = 7
      compliance_level   = "UNSPECIFIED"
      enable_non_security = false
      patch_baseline_filters = [
        {
          name   = "PRODUCT"
          values = ["WindowsServer2016", "WindowsServer2012R2"]
        },
        {
          name   = "CLASSIFICATION"
          values = ["CriticalUpdates", "SecurityUpdates"]
        },
        {
          name   = "MSRC_SEVERITY"
          values = ["Critical", "Important"]
        }
      ]
    }
  ]

  # parameters for scan : associated patch_group "scan" to this patch baseline
  enable_mode_scan = true
}

# register as default patch baseline our patch baseline
module "register_patch_baseline_windows" {
  source = "../../register_default_patch_baseline"

  set_default_patch_baseline = true
  patch_baseline_id          = module.patch_baseline_windows.patch_baseline_id
  operating_system           = local.operating_system_windows
}
