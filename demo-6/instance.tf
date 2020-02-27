module "NetworkModule" {
   source = "./module/Network"
}
resource  "aws_instance" "instance1" {
  ami = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  key_name = "my-personal-key"
  subnet_id = module.NetworkModule.public_subnet_id
  vpc_security_group_ids = ["${module.NetworkModule.sg_id}"]
  tags = {
  Environment = var.environment_tag
   }
  }
