module "NetworkModule" {
    source = "../module/Network" 
}
module "sgmodule"{
    source = "../module/sg"
    vpc = module.NetworkModule.vpc_id
}
resource "aws_instance" "web_dev" {
    ami = var.AMIS[var.REGION]
    instance_type = "t2.micro"
    key_name = aws_key_pair.web_dev_key.key_name
    subnet_id = module.NetworkModule.public_subnet_id
    vpc_security_group_ids = ["${module.sgmodule.sg_id}"]
    tags = {
        Name = "web_dev"
    }
}
resource "aws_instance" "web_private_dev" {
    ami = var.AMIS[var.REGION]
    instance_type = "t2.micro"
    key_name = aws_key_pair.web_dev_key.key_name
    subnet_id = module.NetworkModule.private_subnet_id
    vpc_security_group_ids = ["${module.sgmodule.sg_id}"]
    tags = {
        Name = "web_private_dev"
    }
}

