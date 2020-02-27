resource "aws_key_pair" "ec2-key" {
  key_name = "my-personal-key"
  public_key = file(var.AWS_PUBLICKEY)
}
resource "aws_instance" "instance-1" {
ami           = var.AMIS[var.AWS_REGION]
instance_type = "t2.micro"
key_name      = aws_key_pair.ec2-key.key_name
  provisioner "file" {
  source      = "/home/test_copy"
  destination = "/home/ubuntu/test_copy"
  }
  provisioner "remote-exec" {
  inline =[
     "chmod +x /home/ubuntu/test_copy",
     "bash /home/ubuntu/test_copy"
  ]
  }
  connection {
     host = self.public_ip
     type = "ssh"
     user = var.AWS_SSH_USER
     private_key =file(var.AWS_PRIVATEKEY)
  }
  privisioner "local-exec" {
     command = "echo ${aws_instance.instance-1.private_ip} >> private.txt"
  }
}
output "ip" {
value = self.public_ip
}
