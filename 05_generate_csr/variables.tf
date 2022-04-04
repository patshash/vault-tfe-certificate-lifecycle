variable "csr_organization" {
    description = "Certificate IP SAN"
    default = [""]
}

variable "common_name" {
    description = "Certificate common name"
}

variable "csr_organizational_unit" {
    description = "Certificate alternate name"
    default = ""
}

variable "email" {
    description = "Certificate contact email"
}

variable "csr_street_address" {
    description = "Certificate IP SAN"
    default = [""]
}

variable "csr_locality" {
    description = "Certificate common name"
    default = ""
}

variable "csr_province" {
    description = "Certificate alternate name"
    default = [""]
}

variable "csr_country" {
    description = "Certificate contact email"
    default = ""
}

variable "csr_postal_code" {
    description = "Certificate contact email"
    default = ""
}
