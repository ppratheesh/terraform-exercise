/*
variable AWS_ACCESS_KEY {}
variable AWS_SECRET_KEY {}
*/
variable AWS_REGION {
default = "ap-south-1"
}
variable AMIS {
type = map
default ={
  ap-south-1 = "ami-0f2e255ec956ade7f"
 }
}
