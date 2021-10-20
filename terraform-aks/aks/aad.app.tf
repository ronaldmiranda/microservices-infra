resource "azuread_application" "aks" {
  display_name = format("%s-aks", var.prefix)
}

resource "time_rotating" "time" {
  rotation_years = 10
}

resource "azuread_application_password" "aks" {
  application_object_id = azuread_application.aks.object_id

  rotate_when_changed = {
    rotation = time_rotating.time.id
  }
}

resource "azuread_service_principal" "aks" {
  application_id = azuread_application.aks.application_id
}

resource "azuread_service_principal_password" "aks" {
  service_principal_id = azuread_service_principal.aks.object_id

  rotate_when_changed = {
    rotation = time_rotating.time.id
  }
}
