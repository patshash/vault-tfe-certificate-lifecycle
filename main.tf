provider "tfe" {
  hostname = var.hostname
  token = var.token
}

provider "github" {
  #token = var.oauthid
}


locals {
  # Take a directory of JSON files, read each one and bring them in to Terraform's native data set
  var_certs_w_csr = [ for file in fileset(path.module, "./Customer_Data/submitted_csr/*") : yamldecode(file(file)) ]

  # Take that data set and format it so that it can be used with the for_each command by converting it to a map
  # where each top level key is a unique identifier.
  # In this case I am using the common_name key from my example JSON files
  certsmap_w_csr = { for certs in toset(local.var_certs_w_csr): certs.common_name => certs }


  var_certs_gen_csr = [ for file in fileset(path.module, "./Customer_Data/generate_csr/*.json") : jsondecode(file(file)) ]
  certsmap_gen_csr = {for certs in toset(local.var_certs_gen_csr): certs.common_name => certs}


  var_certs_only = [ for file in fileset(path.module, "./Customer_Data/cert_only/*.json") : jsondecode(file(file)) ]
  certsmap_only = {for certs in toset(local.var_certs_only): certs.common_name => certs}
}


module "workspace_controller" {
    source = "./modules/workspace_controller_w_csr"
    for_each = local.certsmap_w_csr

    organisation = each.value.tfc_organisation
    common_name = each.value.common_name
    common_name_tfc = each.value.common_name_tfc
    email = each.value.email
    username = each.value.username
    certificate_file = each.value.certificate_file
    oauthid = var.oauthid
}


module "workspace_controller_gen_csr" {
    source = "./modules/workspace_controller_gen_csr"
    for_each = local.certsmap_gen_csr

    organization = each.value.tfc_organisation
    common_name = each.value.common_name
    common_name_tfc = each.value.common_name_tfc
    email = each.value.email
    username = each.value.username
    oauthid = var.oauthid
    
    organizational_unit = each.value.organizational_unit
    street_address = each.value.street_address
    locality = each.value.locality
    province = each.value.province
    country = each.value.country
    postal_code = each.value.postal_code
}

module "workspace_controller_cert_only" {
    source = "./modules/workspace_controller_cert_only"
    for_each = local.certsmap_only

    organisation = each.value.tfc_organisation
    common_name = each.value.common_name
    common_name_tfc = each.value.common_name_tfc
    email = each.value.email
    username = each.value.username
    oauthid = var.oauthid

    ip_sans = each.value.ip_sans[0]
    alt_names = each.value.alt_names[0]

}