module "NetworkModule" {
    source = "./module/Network" 
}
module "sgmodule"{
    source = "./module/sg"
    vpc = module.NetworkModule.vpc_id
}
resource "aws_instance" "web_dev" {
    ami = var.AMIS[var.REGION]
    instance_type = "t2.micro"
    subnet_id = module.NetworkModule.public_subnet_id
    vpc_security_group_ids = ["${module.sgmodule.sg_id}"]
    tags = {
        Name = "web_dev"
    }
}
