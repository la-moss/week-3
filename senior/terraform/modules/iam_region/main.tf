resource "azurerm_resource_group" "rg" {
  name     = "${var.name_prefix}-rg-${replace(var.location, " ", "")}"
  location = var.location
  tags     = var.tags
}

resource "azurerm_user_assigned_identity" "automation" {
  name                = "${var.name_prefix}-id-${replace(var.location, " ", "")}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}

resource "azurerm_role_definition" "custom" {
  name        = uuidv5("dns", "${var.role_name}-${azurerm_resource_group.rg.name}")
  scope       = azurerm_resource_group.rg.id
  description = "Operational permissions for automation workflows in the service resource group."

  permissions {
    actions = [
      "Microsoft.Resources/subscriptions/resourceGroups/read",
      "Microsoft.Resources/subscriptions/resourceGroups/resources/read",
      "Microsoft.ManagedIdentity/userAssignedIdentities/read",
      "Microsoft.ManagedIdentity/userAssignedIdentities/assign/action",
      "Microsoft.Authorization/roleAssignments/read",
      "Microsoft.Authorization/roleAssignments/write",
      "Microsoft.KeyVault/vaults/read",
      "Microsoft.KeyVault/vaults/secrets/read",
      "Microsoft.KeyVault/vaults/secrets/set/action",
      "*"
    ]
    not_actions = []
  }

  assignable_scopes = [
    azurerm_resource_group.rg.id
  ]
}

resource "azurerm_role_assignment" "automation_on_rg" {
  scope              = azurerm_resource_group.rg.id
  role_definition_id = azurerm_role_definition.custom.role_definition_resource_id
  principal_id       = azurerm_user_assigned_identity.automation.principal_id
}
