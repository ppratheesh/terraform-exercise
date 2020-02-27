module "NetworkModule" {
   source = "./Network"
}
resource "aws_instance" "instance_public" {
    ami           = var.AMIS[var.AWS_REGION]
    instance_type = "t2.micro"
    key_name      = "my-personal-key"
    subnet_id     = module.NetworkModule.public_subnet_id
    vpc_security_groups_id = ["${module.NetworkModule.sg_id}"]
    provisioner "file" {
      source = "/home/test_copy"
      destination = "/home/ubuntu/test_copy"
    }
    provisioner "remote-exec" {
    inline = [
       "chown +x /home/ubuntu/test_copy",
       "bash /home/ubuntu/test_copy"
    ]
    }
    connection {
      host = self.public_ip
      type = "ssh"
      user = var.AWS_SSH_USER
      private_key = file(var.AWS_PRIVATEKEY)
    }
    provisioner "local-exec" {
    command = "echo private_ip=${self.private_ip} >> /tmp/private_ip.txt"
     }
}
resource "aws_instance" "instance_private"
