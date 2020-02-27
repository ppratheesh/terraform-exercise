#resource "aws_key_pair" "key1" {
#key_name = "my-personal-key"
#}
resource "aws_instance" "instance1" {
ami           = var.AMIS[var.AWS_REGION]
instance_type = "t2.micro"
key_name   = "my-personal-key"
provisioner "file" {
  source = "/home/test_copy"
  destination = "/home/ubuntu/test_copy"
}
provisioner "remote-exec" {
inline=[
   "chmod +x /home/ubuntu/test_copy",
   "bash /home/ubuntu/test_copy"
]
}
connection {
   host = self.public_ip
   type = "ssh"
   user = "ubuntu"
   private_key = file(var.AWS_PRIVATEKEY)
}
provisioner "local-exec" {
command = "echo ${self.private_ip} >> private.txt"
 }
}
output "ip" {
value = aws_instance.instance1.public_ip
}
