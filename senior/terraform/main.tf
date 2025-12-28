module "iam_primary" {
  source = "./modules/iam_region"

  name_prefix   = local.name_prefix
  location      = var.primary_location
  role_name     = local.role_name_primary
  principal_oid = var.automation_principal_object_id
  tags          = var.tags
}

module "iam_secondary" {
  source = "./modules/iam_region"

  providers = {
    azurerm = azurerm.secondary
  }

  name_prefix   = local.name_prefix
  location      = var.secondary_location
  role_name     = local.role_name_secondary
  principal_oid = var.automation_principal_object_id
  tags          = var.tags
}
