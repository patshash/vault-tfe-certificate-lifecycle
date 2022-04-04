resource "tfe_workspace" "create-workspace" {

  name         = var.common_name_tfc
  organization = var.organization
  description = "Workspace for team certs"
  auto_apply = true
  global_remote_state = true
  execution_mode = "remote"
  tag_names = ["certificate", "Cert-Gen-CSR"]
  #remote_state_consumervids = var.state_consumers
  working_directory = "05_generate_csr"

  vcs_repo {
      identifier = "patshash/tf_vault_certificate_automation"
      branch = "demo"
      oauth_token_id = var.oauthid
  }
}

resource "tfe_variable" "var-cn" {

  key          = "common_name"
  value        = var.common_name
  category     = "terraform"
  workspace_id = tfe_workspace.create-workspace.id
  description  = "Common name for the certificate"
}

resource "tfe_variable" "var-email" {

  key          = "email"
  value        = var.email
  category     = "terraform"
  workspace_id = tfe_workspace.create-workspace.id
  description  = "email address of primary contact"
}

resource "tfe_variable" "var-csr-organization" {

  key          = "csr_organization"
  value        = var.organization
  category     = "terraform"
  workspace_id = tfe_workspace.create-workspace.id
  description  = "email address of primary contact"
}

resource "tfe_variable" "var-csr-organizational-unit" {

  key          = "csr_organizational_unit"
  value        = var.organizational_unit
  category     = "terraform"
  workspace_id = tfe_workspace.create-workspace.id
  description  = "email address of primary contact"
}
resource "tfe_variable" "var-csr-street-address" {

  key          = "csr_street_address"
  value        = var.street_address[0]
  category     = "terraform"
  workspace_id = tfe_workspace.create-workspace.id
  description  = "email address of primary contact"
}
resource "tfe_variable" "var-csr-locality" {

  key          = "csr_locality"
  value        = var.locality
  category     = "terraform"
  workspace_id = tfe_workspace.create-workspace.id
  description  = "email address of primary contact"
}
resource "tfe_variable" "var-csr-province" {

  key          = "csr_province"
  value        = var.province
  category     = "terraform"
  workspace_id = tfe_workspace.create-workspace.id
  description  = "email address of primary contact"
}
resource "tfe_variable" "var-csr-country" {

  key          = "csr_country"
  value        = var.country
  category     = "terraform"
  workspace_id = tfe_workspace.create-workspace.id
  description  = "email address of primary contact"
}
resource "tfe_variable" "var-postal-code" {

  key          = "csr_postal_code"
  value        = var.postal_code
  category     = "terraform"
  workspace_id = tfe_workspace.create-workspace.id
  description  = "email address of primary contact"
}
resource "tfe_variable" "var-username" {

  key          = "username"
  value        = var.username
  category     = "terraform"
  workspace_id = tfe_workspace.create-workspace.id
  description  = "name of primary contact"
}
/*
resource "tfe_team" "certificates-team" {
  for_each = local.certsmap
  name         = "Certificate-team-${each.value.common_name_tfc}"
  organization = var.organisation
}

resource "tfe_team_member" "test" {
  for_each = local.certsmap

  team_id  = tfe_team.certificates-team[each.key].id
  username = each.value.username
}

resource "tfe_team_access" "certificates-team-access" {
  for_each = local.certsmap

  access       = "read"
  team_id      = tfe_team.certificates-team[each.key].id
  workspace_id = tfe_workspace.create-workspace["${each.value.common_name}"].id
}

data "tfe_organization_membership" "test" {
  organization  = "pcarey-org"
  email = "pcarey@hashicorp.com"
}

resource "tfe_notification_configuration" "test" {
  for_each = local.certsmap

  name             = "my-notification-configuration"
  enabled          = true
  destination_type = "email"
  email_user_ids   = [data.tfe_organization_membership.test.user_id]
  triggers         = ["run:created", "run:planning", "run:errored"]
  workspace_id     = tfe_workspace.create-workspace["${each.value.common_name}"].id
}
*/