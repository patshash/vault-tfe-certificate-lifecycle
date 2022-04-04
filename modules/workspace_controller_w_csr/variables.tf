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

variable "organisation" {
    description = "Name of the organisation"
    default = "pcarey-demo"
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
    default = ""
}

variable "common_name_tfc" {
    description = "The user token for TFC"
    default = ""
}

variable "email" {
    description = "The user token for TFC"
    default = ""
}

variable "username" {
    description = "The user token for TFC"
    default = ""
}
 
variable "certificate_file" {
    description = "The user token for TFC"
    default = ""
}