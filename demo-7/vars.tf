variable "cidr_vpc" {
default = "10.0.0.0/16"
}
variable "cidr_public" {
  default = "10.0.0.0/27"
}
variable "cidr_private" {
 default = "10.0.0.32/27"
}
variable "avail_pub" {
default="us-east-1a"
}
variable  "avail_private" {
 default =  "us-east-1b"
}
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable AWS_REGION {
   default = "us-east-1"
}
variable "AMIS" {
type = map
default = {
us-east-1 = "ami-046842448f9e74e7d"
}
}
