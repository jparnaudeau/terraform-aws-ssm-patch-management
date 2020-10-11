variable "environment" {
  description = "This label will be added after 'name' on all resources, and be added as the value for the 'Environment' tag where supported"
  type        = string
}

variable "patch_baseline_label" {
  description = "This label will be added after 'envname' on all resources"
  type        = string
  default     = "ssmpbl"
}

variable "tags" {
  description = "map of tags to associated on patch_baseline"
  type        = map(string)
  default     = {}
}

variable "scan_patch_groups" {
  description = "The list of scan patching groups, one target will be created per entry in this list. Update default value only if you know what you do"
  type        = list(string)
  default     = ["TOSCAN"]
}

variable "operating_system" {
  description = "Defines the operating system the patch baseline applies to. Supported operating systems include WINDOWS, AMAZON_LINUX, AMAZON_LINUX_2, SUSE, UBUNTU, CENTOS, and REDHAT_ENTERPRISE_LINUX."
  type        = string
}

variable "description" {
  description = "Desscription of the Patch Baseline"
  type        = string
}

variable "enable_mode_scan" {
  description = "Enable/Disable the mode 'scan' for PatchManager"
  type        = bool
  default     = false
}

variable "install_patch_groups" {
  description = "The list of install patching groups, one target will be created per entry in this list. Update default value only if you know what you do"
  type        = list(string)
  default     = ["TOPATCH"]
}

variable "approved_patches" {
  description = "The list of approved patches for the SSM baseline"
  type        = list(string)
  default     = []
}

variable "rejected_patches" {
  description = "The list of rejected patches for the SSM baseline"
  type        = list(string)
  default     = []
}

variable "patch_baseline_approval_rules" {
  description = "list of approval rules defined in the patch baseline (Max 10 rules). For compliance_level, it means that if an approved patch is reported as missing, this is the severity of the compliance violation. Valid compliance levels include the following: CRITICAL, HIGH, MEDIUM, LOW, INFORMATIONAL, UNSPECIFIED. The default value is UNSPECIFIED."
  type = list(object({
    approve_after_days : number
    compliance_level : string
    enable_non_security : bool
    patch_baseline_filters : list(object({
      name : string
      values : list(string)
    }))
  }))

  default = [
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

}


variable "approved_patches_compliance_level" {
  type        = string
  description = "Defines the compliance level for approved patches. This means that if an approved patch is reported as missing, this is the severity of the compliance violation. Valid compliance levels include the following: CRITICAL, HIGH, MEDIUM, LOW, INFORMATIONAL, UNSPECIFIED. The default value is UNSPECIFIED."
  default     = "UNSPECIFIED"
}
