variable "REGION" {default = "us-east-1"}
variable "AMIS" {
    type = map
    default = {
        us-east-1 = "ami-046842448f9e74e7d"
    }
}
variable "PUBLIC_KEY" { default = "mykey.pub" } 
