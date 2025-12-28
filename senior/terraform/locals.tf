locals {
  name_prefix = "${var.project}-${var.environment}"

  # Role definition name constraints are tighter than many Azure resources.
  role_name_primary   = "${var.project}-automation-ops"
  role_name_secondary = "${var.project}-automation-ops-dr"
}
