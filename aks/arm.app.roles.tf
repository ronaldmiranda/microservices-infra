resource "azurerm_role_assignment" "role_assigngment_app_reader" {
  role_definition_name = "Reader"
  scope                = azurerm_resource_group.rg.id
  principal_id         = azuread_service_principal.aks.object_id
}

resource "azurerm_role_assignment" "role_assigngment_app_sa_contributor" {
  role_definition_name = "Storage Account Contributor"
  scope                = azurerm_role_assignment.role_assigngment_app_reader.scope
  principal_id         = azurerm_role_assignment.role_assigngment_app_reader.principal_id
}

resource "azurerm_role_assignment" "role_assingment_app_mi_operator" {
  role_definition_name = "Managed Identity Operator"
  scope                = azurerm_user_assigned_identity.idenitity_aks.id
  principal_id         = azuread_service_principal.aks.object_id
}
