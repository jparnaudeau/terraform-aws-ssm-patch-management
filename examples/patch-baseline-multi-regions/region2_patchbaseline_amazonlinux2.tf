
#####
# Create Patch Baselines for amazonlinux
#####

module "r2_patch_baseline_amazonlinux2" {
  source = "../../patch_baseline"

  # define the second region
  providers = {
    aws = aws.second_region
  }

  # tags parameters
  environment = var.environment

  # patch baseline parameters
  approved_patches_compliance_level = "HIGH"
  operating_system                  = local.operating_system_amazon_linux2
  description                       = "AmazonLinux2 - PatchBaseLine - Apply Critical Security Updates"
  tags                              = var.tags

  # define rules inside patch baseline
  patch_baseline_approval_rules = [
    {
      approve_after_days  = 10
      compliance_level    = "CRITICAL"
      enable_non_security = false
      patch_baseline_filters = [
        {
          name   = "PRODUCT"
          values = ["AmazonLinux2", "AmazonLinux2.0"]
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
module "r2_register_patch_baseline_amazonlinux2" {
  source = "../../register_default_patch_baseline"

  # define the second provider
  providers = {
    aws = aws.second_region
  }

  region                     = var.second_region
  set_default_patch_baseline = true
  patch_baseline_id          = module.r2_patch_baseline_amazonlinux2.patch_baseline_id
  operating_system           = local.operating_system_amazon_linux2
}