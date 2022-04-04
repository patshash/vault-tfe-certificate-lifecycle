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

variable "ip_sans" {
    description = "Certificate IP SAN"
    default = [""]
}

variable "common_name" {
    description = "Certificate common name"
}
variable "common_name_tfc" {
    description = "Certificate common name"
}


variable "alt_names" {
    description = "Certificate alternate name"
    default = [""]
}

variable "email" {
    description = "Certificate contact email"
}


variable "username" {
    description = "The user token for TFC"
    default = ""
}