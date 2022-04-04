variable "ip_sans" {
    description = "Certificate IP SAN"
    default = [""]
}

variable "common_name" {
    description = "Certificate common name"
}

variable "alt_names" {
    description = "Certificate alternate name"
    default = [""]
}

variable "email" {
    description = "Certificate contact email"
}