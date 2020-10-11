variable "patch_baseline_id" {
  description = "Patch Baseline Id that we want to set default patch baseline"
  type        = string
}

variable "operating_system" {
  description = "operating system related to the patch baseline that we want to set default"
  type        = string
}

variable "set_default_patch_baseline" {
  description = "If true, the command will be launched"
  type        = bool
  default     = false
}