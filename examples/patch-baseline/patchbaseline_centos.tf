locals {
  operating_system_centos = "CENTOS"
}

#####
# Create Patch Baselines for Centos
#####
module "patch_baseline_centos" {
  source = "../../patch_baseline"

  # tags parameters
  environment = var.environment

  # patch baseline parameters
  approved_patches_compliance_level = "HIGH"
  operating_system                  = local.operating_system_centos
  description                       = "CentOS - PatchBaseLine - Apply Critical Security Updates"
  tags                              = var.tags

  # define rules inside patch baseline
  patch_baseline_approval_rules = [
    {
      approve_after_days  = 7
      compliance_level    = "CRITICAL"
      enable_non_security = true
      patch_baseline_filters = [
        {
          name   = "PRODUCT"
          values = ["CentOS6.10", "CentOS6.5", "CentOS6.6", "CentOS6.7", "CentOS6.8", "CentOS6.9", "CentOS7.0", "CentOS7.1", "CentOS7.2", "CentOS7.3", "CentOS7.4", "CentOS7.5", "CentOS7.6", "CentOS7.7", "CentOS7.8", "CentOS8", "CentOS8.0", "CentOS8.1"]
        },
        {
          name   = "CLASSIFICATION"
          values = ["Security"]
        },
        {
          name   = "SEVERITY"
          values = ["Critical"]
        }
      ]
    }
  ]

  # parameters for scan : associated patch_group "scan" to this patch baseline
  enable_mode_scan = true
}

# register as default patch baseline our patch baseline
module "register_patch_baseline_centos" {
  source = "../../register_default_patch_baseline"

  set_default_patch_baseline = true
  patch_baseline_id          = module.patch_baseline_centos.patch_baseline_id
  operating_system           = local.operating_system_centos
}
