locals {
  operating_system_amazon_linux  = "AMAZON_LINUX"
}

#####
# Create Patch Baselines for amazonlinux
#####
module "patch_baseline_amazonlinux" {
  source = "../../patch_baseline"

  # tags parameters
  environment = var.environment

  # patch baseline parameters
  approved_patches_compliance_level = "HIGH"
  operating_system                  = local.operating_system_amazon_linux
  description                       = "AmazonLinux - PatchBaseLine - Apply Critical Security Updates + Critical Bugfix Updates"
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
          values = ["AmazonLinux2012.03", "AmazonLinux2013.03", "AmazonLinux2013.09", "AmazonLinux2014.03", "AmazonLinux2014.09", "AmazonLinux2015.03", "AmazonLinux2015.09", "AmazonLinux2016.03", "AmazonLinux2016.09", "AmazonLinux2017.03", "AmazonLinux2017.09", "AmazonLinux2018.03"]
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
    },
    {
      approve_after_days  = 7
      compliance_level    = "MEDIUM"
      enable_non_security = false
      patch_baseline_filters = [
        {
          name   = "PRODUCT"
          values = ["AmazonLinux2012.03", "AmazonLinux2013.03", "AmazonLinux2013.09", "AmazonLinux2014.03", "AmazonLinux2014.09", "AmazonLinux2015.03", "AmazonLinux2015.09", "AmazonLinux2016.03", "AmazonLinux2016.09", "AmazonLinux2017.03", "AmazonLinux2017.09", "AmazonLinux2018.09"]
        },
        {
          name   = "CLASSIFICATION"
          values = ["Bugfix"]
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
module "register_patch_baseline_amazonlinux" {
  source = "../../register_default_patch_baseline"

  set_default_patch_baseline = true
  patch_baseline_id          = module.patch_baseline_amazonlinux.patch_baseline_id
  operating_system           = local.operating_system_amazon_linux
}
