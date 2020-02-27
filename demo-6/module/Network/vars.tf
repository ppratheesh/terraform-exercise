variable "cidr_vpc" {
default = "10.0.0.0/16"
}
variable "cidr_public_subnet" {
default = "10.0.0.0/27"
}
variable "cidr_private_subnet" {
default = "10.0.0.32/27"
}
variable "availability_zone_pubic" {
default = "us-east-1a"
}
variable "availability_zone_private" {
default = "us-east-1b"
}
variable "environment_tag" {
default = "DEV"
}
