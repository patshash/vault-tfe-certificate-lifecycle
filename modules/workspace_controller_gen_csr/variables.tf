variable "oauthid" {
    description = "The Oauth ID for Github"
    default = ""
}

variable "project_name" {
    description = "The name of the project"
    default = "not-used"
}

variable "token" {
    description = "The user token for TFC"
    default = ""
}

variable "hostname" {
    description = "The hostname of TFE or TFC"
    default = "app.terraform.io"
}

variable "state_consumers" {
    description = "A list of all workspaces that have permission to access the state of this workspace"
    default = []
}

variable "common_name" {
    description = "The user token for TFC"
}

variable "common_name_tfc" {
    description = "The user token for TFC"
}

variable "email" {
    description = "The user token for TFC"
}

variable "organization" {
    description = "The user token for TFC"
}

variable "organizational_unit" {
    description = "The user token for TFC"
}

variable "street_address" {
    description = "The user token for TFC"
}

variable "locality" {
    description = "The user token for TFC"
}

variable "province" {
    description = "The user token for TFC"
}

variable "country" {
    description = "The user token for TFC"
}

variable "postal_code" {
    description = "The user token for TFC"
}

variable "username" {
    description = "The user token for TFC"
}