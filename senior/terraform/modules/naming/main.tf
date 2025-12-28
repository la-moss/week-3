variable "project" { type = string }
variable "environment" { type = string }
variable "location" { type = string }

locals {
  compact_location = replace(lower(var.location), " ", "")
  prefix           = "${var.project}-${var.environment}-${local.compact_location}"
}

output "prefix" {
  value = local.prefix
}
