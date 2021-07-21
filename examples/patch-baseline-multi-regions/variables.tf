# ===========================================================
# Common Attributes
# ===========================================================
variable "first_region" {
  description = "The First AWS Region"
  type        = string
}

variable "second_region" {
  description = "The Second AWS Region"
  type        = string
}

variable "environment" {
  description = "Envrionment name. Use in naming resources"
  type        = string
}

variable "tags" {
  description = "a map of tags to put on resources"
  type        = map(string)
  default     = {}
}


variable "ssm_patch_logs_prefix" {
  description = "The prefix to use in S3 Bucket to store patch logs"
  type        = string
  default     = "myapp"
}

