variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION"  {
default = "us-east-1"
}
variable "AMIS" {
type = map
default = {
us-east-1 = "ami-046842448f9e74e7d"
 }
}
variable "AWS_PRIVATEKEY" {
default = "key.pem"
}
variable "AWS_SSH_USER" {
default = "ubuntu"
}
