# resource "azurerm_app_service" "app_as" {
#   name                = format("%s-%s", var.app_rg_name, "as")
#   resource_group_name = var.app_rg_name
#   location            = var.rg_location
#   app_service_plan_id = azurerm_app_service_plan.app_asp.id

#   client_affinity_enabled = true
#   https_only              = true
#   # this needs to be defined

#   site_config {
#     always_on = true
#     default_documents = [
#       "Default.htm",
#       "Default.html",
#       "Default.asp",
#       "index.htm",
#       "index.html",
#       "iisstart.htm",
#       "default.aspx",
#       "index.php",
#       "hostingstart.html",
#     ]
#     health_check_path         = "/healthcheck"
#     scm_type                  = "None"
#     use_32_bit_worker_process = true
#   }

#   app_settings = {
#     "ADMIN_ALLOWED_IPS"                              = data.azurerm_key_vault_secret.AdminAllowedIPs.value
#     "APPINSIGHTS_INSTRUMENTATIONKEY"                 = data.azurerm_application_insights.app_ai.instrumentation_key
#     "CANONICAL_HOSTNAME"                             = local.verify_entity_id
#     "DFE_SIGN_IN_API_CLIENT_ID"                      = data.azurerm_key_vault_secret.DfeSignInApiClientId.value
#     "DFE_SIGN_IN_API_ENDPOINT"                       = data.azurerm_key_vault_secret.DfeSignInApiEndpoint.value
#     "DFE_SIGN_IN_API_SECRET"                         = data.azurerm_key_vault_secret.DfeSignInApiSecret.value
#     "DFE_SIGN_IN_IDENTIFIER"                         = data.azurerm_key_vault_secret.DfeSignInIdentifier.value
#     "DFE_SIGN_IN_ISSUER"                             = data.azurerm_key_vault_secret.DfeSignInIssuer.value
#     "DFE_SIGN_IN_REDIRECT_BASE_URL"                  = data.azurerm_key_vault_secret.DfeSignInRedirectBaseUrl.value
#     "DFE_SIGN_IN_SECRET"                             = data.azurerm_key_vault_secret.DfeSignInSecret.value
#     "DFE_TEACHERS_PAYMENT_SERVICE_DATABASE_HOST"     = format("%s.%s", format("%s-%s", var.app_rg_name, "db"), "postgres.database.azure.com")
#     "DFE_TEACHERS_PAYMENT_SERVICE_DATABASE_NAME"     = local.environment
#     "DFE_TEACHERS_PAYMENT_SERVICE_DATABASE_PASSWORD" = data.azurerm_key_vault_secret.DatabasePassword.value
#     "DFE_TEACHERS_PAYMENT_SERVICE_DATABASE_USERNAME" = format("%s@%s", data.azurerm_key_vault_secret.DatabaseUsername.value, format("%s-%s", var.app_rg_name, "db")) # "tps_development@s118d01-app-db"
#     "DOCKER_REGISTRY_SERVER_URL"                     = "https://index.docker.io" 
#     "ENVIRONMENT_NAME"                               = local.environment
#     "GECKOBOARD_API_KEY"                             = data.azurerm_key_vault_secret.GeckoboardAPIKey.value
#     "GOOGLE_ANALYTICS_ID"                            = ""
#     "LOGSTASH_HOST"                                  = data.azurerm_key_vault_secret.LogstashHost.value
#     "LOGSTASH_PORT"                                  = local.stash_port
#     "NOTIFY_API_KEY"                                 = data.azurerm_key_vault_secret.NotifyApiKey.value
#     "RAILS_ENV"                                      = "production" #local.environment
#     "RAILS_SERVE_STATIC_FILES"                       = "true"
#     "ROLLBAR_ACCESS_TOKEN"                           = data.azurerm_key_vault_secret.RollbarInfraToken.value
#     "SECRET_KEY_BASE"                                = data.azurerm_key_vault_secret.SecretKeyBase.value
#     "WORKER_COUNT"                                   = "2"
#     #    "GOVUK_VERIFY_VSP_HOST"                          = format("%s%s.%s", "https://", azurerm_app_service.app_vsp_as.name, "azurewebsites.net")    
#   }

#   tags = merge({
#     },
#     var.common_tags
#   )

# }
