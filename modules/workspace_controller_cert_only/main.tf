resource "tfe_workspace" "create-workspace" {
  name         = var.common_name_tfc
  organization = var.organisation
  description = "Workspace for team certs"
  auto_apply = true
  global_remote_state = true
  execution_mode = "remote"
  tag_names = ["certificate"]
  #remote_state_consumer_ids = var.state_consumers
  working_directory = "04_cert_only"

  vcs_repo {
      identifier = "patshash/vault-tfe-certificate-lifecycle"
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

resource "tfe_variable" "var-alt" {
  key          = "alt_names"
  value        = var.alt_names
  category     = "terraform"
  workspace_id = tfe_workspace.create-workspace.id
  description  = "certificate alternate name"
}

resource "tfe_variable" "var-san" {
  key          = "ip_sans"
  value        = var.ip_sans
  category     = "terraform"
  workspace_id = tfe_workspace.create-workspace.id
  description  = "certificate SANs"
}

resource "tfe_variable" "var-email" {
  key          = "email"
  value        = var.email
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
  organization  = "pcarey-demo"
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