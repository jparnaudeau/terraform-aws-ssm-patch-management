locals {
  operating_system_rhel = "REDHAT_ENTERPRISE_LINUX"
}

#####
# Create Patch Baselines for redHatEnterpriseLinux
#####
module "patch_baseline_rhel" {
  source = "../../patch_baseline"

  # tags parameters
  environment = var.environment

  # patch baseline parameters
  approved_patches_compliance_level = "CRITICAL"
  operating_system                  = local.operating_system_rhel
  description                       = "RedHat Enterprise Linux - PatchBaseLine - Apply Critical Security Updates"
  tags                              = var.tags

  # define rules inside patch baseline
  patch_baseline_approval_rules = [
    {
      approve_after_days  = 7
      compliance_level    = "CRITICAL"
      enable_non_security = false
      patch_baseline_filters = [
        {
          name   = "PRODUCT"
          values = ["RedhatEnterpriseLinux6.10", "RedhatEnterpriseLinux6.5", "RedhatEnterpriseLinux6.6", "RedhatEnterpriseLinux6.7", "RedhatEnterpriseLinux6.8", "RedhatEnterpriseLinux6.9", "RedhatEnterpriseLinux7", "RedhatEnterpriseLinux7.0", "RedhatEnterpriseLinux7.1", "RedhatEnterpriseLinux7.2", "RedhatEnterpriseLinux7.3", "RedhatEnterpriseLinux7.4", "RedhatEnterpriseLinux7.5", "RedhatEnterpriseLinux7.6", "RedhatEnterpriseLinux7.7", "RedhatEnterpriseLinux7.8", "RedhatEnterpriseLinux8", "RedhatEnterpriseLinux8.0", "RedhatEnterpriseLinux8.1", "RedhatEnterpriseLinux8.2"]
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
module "register_patch_baseline_rhel" {
  source = "../../register_default_patch_baseline"

  set_default_patch_baseline = true
  patch_baseline_id          = module.patch_baseline_rhel.patch_baseline_id
  operating_system           = local.operating_system_rhel
}
