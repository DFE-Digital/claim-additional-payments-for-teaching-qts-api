resource "azurerm_container_group" "cont_reg_01" {
  name                = format("%s-%s", var.app_rg_name, "worker-aci")
  location            = var.rg_location
  resource_group_name = var.app_rg_name
  ip_address_type     = "Private"
  # ip_address_type = "Public"
  dns_name_label = "s118d01-aci-label-01"
  os_type        = "Linux"
  # network_profile_id = var.projcore_network_prof

  container {
    name   = format("%s-%s", var.app_rg_name, "worker-container")
    image  = format("%s%s", "dfedigital/teacher-payments-service:", var.container_version)
    cpu    = "1"
    memory = "1.5"

    environment_variables = {
      "ADMIN_ALLOWED_IPS"                              = data.azurerm_key_vault_secret.AdminAllowedIPs.value
      "APPINSIGHTS_INSTRUMENTATIONKEY"                 = data.azurerm_application_insights.app_ai.instrumentation_key
      "CANONICAL_HOSTNAME"                             = local.verify_entity_id
      "DFE_SIGN_IN_API_CLIENT_ID"                      = data.azurerm_key_vault_secret.DfeSignInApiClientId.value
      "DFE_SIGN_IN_API_ENDPOINT"                       = data.azurerm_key_vault_secret.DfeSignInApiEndpoint.value
      "DFE_SIGN_IN_API_SECRET"                         = data.azurerm_key_vault_secret.DfeSignInApiSecret.value
      "DFE_SIGN_IN_IDENTIFIER"                         = data.azurerm_key_vault_secret.DfeSignInIdentifier.value
      "DFE_SIGN_IN_ISSUER"                             = data.azurerm_key_vault_secret.DfeSignInIssuer.value
      "DFE_SIGN_IN_REDIRECT_BASE_URL"                  = data.azurerm_key_vault_secret.DfeSignInRedirectBaseUrl.value
      "DFE_SIGN_IN_SECRET"                             = data.azurerm_key_vault_secret.DfeSignInSecret.value
      "DFE_TEACHERS_PAYMENT_SERVICE_DATABASE_HOST"     = format("%s.%s", format("%s-%s", var.app_rg_name, "db"), "postgres.database.azure.com")
      "DFE_TEACHERS_PAYMENT_SERVICE_DATABASE_NAME"     = "development" #local.environment
      "DFE_TEACHERS_PAYMENT_SERVICE_DATABASE_PASSWORD" = data.azurerm_key_vault_secret.DatabasePassword.value
      "DFE_TEACHERS_PAYMENT_SERVICE_DATABASE_USERNAME" = format("%s@%s", data.azurerm_key_vault_secret.DatabaseUsername.value, format("%s-%s", var.app_rg_name, "db")) # "tps_development@s118d01-app-db"
      "ENVIRONMENT_NAME"                               = "development"                                                                                                 #local.environment
      "GECKOBOARD_API_KEY"                             = data.azurerm_key_vault_secret.GeckoboardAPIKey.value
      "GOOGLE_ANALYTICS_ID"                            = ""
      #"GOVUK_VERIFY_VSP_HOST"                          = format("%s%s.%s", "https://", data.azurerm_app_service.app_vsp_as.name, "azurewebsites.net")
      "LOGSTASH_HOST"            = data.azurerm_key_vault_secret.LogstashHost.value
      "LOGSTASH_PORT"            = "17000" #local.stash_port
      "NOTIFY_API_KEY"           = data.azurerm_key_vault_secret.NotifyApiKey.value
      "RAILS_ENV"                = "production" #local.environment
      "RAILS_SERVE_STATIC_FILES" = "true"
      "ROLLBAR_ACCESS_TOKEN"     = data.azurerm_key_vault_secret.RollbarAccessToken.value
      "SECRET_KEY_BASE"          = data.azurerm_key_vault_secret.SecretKeyBase.value
      "WORKER_COUNT"             = "2"
    }

    ports {
      port     = 443
      protocol = "TCP"
    }
  }

  tags = merge({
    },
    var.common_tags
  )
}

resource "azurerm_container_group" "cont_reg_02" {
  name                = format("%s-%s", var.app_rg_name, "migration-runner-aci")
  location            = var.rg_location
  resource_group_name = var.app_rg_name
  dns_name_label      = "s118d01-aci-label-01"
  os_type             = "Linux"
  #  network_profile_id = var.projcore_network_prof
  restart_policy  = "OnFailure"
  ip_address_type = "Private"

  container {
    commands = [
      "bin/prepare-database",
    ]
    environment_variables = {
      "ADMIN_ALLOWED_IPS"                              = data.azurerm_key_vault_secret.AdminAllowedIPs.value
      "APPINSIGHTS_INSTRUMENTATIONKEY"                 = data.azurerm_application_insights.app_ai.instrumentation_key
      "CANONICAL_HOSTNAME"                             = local.verify_entity_id
      "DFE_SIGN_IN_API_CLIENT_ID"                      = data.azurerm_key_vault_secret.DfeSignInApiClientId.value
      "DFE_SIGN_IN_API_ENDPOINT"                       = data.azurerm_key_vault_secret.DfeSignInApiEndpoint.value
      "DFE_SIGN_IN_API_SECRET"                         = data.azurerm_key_vault_secret.DfeSignInApiSecret.value
      "DFE_SIGN_IN_IDENTIFIER"                         = data.azurerm_key_vault_secret.DfeSignInIdentifier.value
      "DFE_SIGN_IN_ISSUER"                             = data.azurerm_key_vault_secret.DfeSignInIssuer.value
      "DFE_SIGN_IN_REDIRECT_BASE_URL"                  = data.azurerm_key_vault_secret.DfeSignInRedirectBaseUrl.value
      "DFE_SIGN_IN_SECRET"                             = data.azurerm_key_vault_secret.DfeSignInSecret.value
      "DFE_TEACHERS_PAYMENT_SERVICE_DATABASE_HOST"     = format("%s.%s", format("%s-%s", var.app_rg_name, "db"), "postgres.database.azure.com")
      "DFE_TEACHERS_PAYMENT_SERVICE_DATABASE_NAME"     = "development"
      "DFE_TEACHERS_PAYMENT_SERVICE_DATABASE_PASSWORD" = data.azurerm_key_vault_secret.DatabasePassword.value
      "DFE_TEACHERS_PAYMENT_SERVICE_DATABASE_USERNAME" = format("%s@%s", data.azurerm_key_vault_secret.DatabaseUsername.value, format("%s-%s", var.app_rg_name, "db")) # "tps_development@s118d01-app-db"
      "ENVIRONMENT_NAME"                               = "development"
      "GECKOBOARD_API_KEY"                             = data.azurerm_key_vault_secret.GeckoboardAPIKey.value
      "GOOGLE_ANALYTICS_ID"                            = ""
      #"GOVUK_VERIFY_VSP_HOST"                          = format("%s%s.%s", "https://", data.azurerm_app_service.app_vsp_as.name, "azurewebsites.net")
      "LOGSTASH_HOST"            = data.azurerm_key_vault_secret.LogstashHost.value
      "LOGSTASH_PORT"            = "17000"
      "NOTIFY_API_KEY"           = data.azurerm_key_vault_secret.NotifyApiKey.value
      "RAILS_ENV"                = "production"
      "RAILS_SERVE_STATIC_FILES" = "true"
      "ROLLBAR_ACCESS_TOKEN"     = data.azurerm_key_vault_secret.RollbarAccessToken.value
      "SECRET_KEY_BASE"          = data.azurerm_key_vault_secret.SecretKeyBase.value
      "WORKER_COUNT"             = "2"

    }

    name   = format("%s-%s", var.app_rg_name, "migration-runner-container")
    image  = format("%s%s", "dfedigital/teacher-payments-service:", var.container_version)
    cpu    = "1"
    memory = "1.5"

    ports {
      port     = 443
      protocol = "TCP"
    }

  }

  tags = merge({
    },
    var.common_tags
  )
}

