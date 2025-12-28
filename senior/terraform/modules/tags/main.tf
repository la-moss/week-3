variable "base" {
  type = map(string)
}

variable "overrides" {
  type    = map(string)
  default = {}
}

locals {
  merged = merge(var.base, var.overrides)
}

output "value" {
  value = local.merged
}
