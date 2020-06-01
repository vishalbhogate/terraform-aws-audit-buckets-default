variable "org_name" {
  description = "Name for this organization (not actually used in API call)"
}

variable "account_ids" {
  default     = []
  description = "AWS Account IDs under Auditing for the organization"
}

variable "s3_days_until_glacier" {
  default     = 90
  description = "How many days before transitioning files to Glacier"
}