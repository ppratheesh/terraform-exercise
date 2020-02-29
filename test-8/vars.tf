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
variable "SSH-USER" {
 default = "ubuntu"
}
variable "PRIVATE_KEY" {
 default = "mykey"
}
variable "PUBLIC_KEY" {
default = "mykey.pub"
}
