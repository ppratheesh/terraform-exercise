resource "aws_instance" "instance1" {
ami =var.AMIS[var.AWS_REGION]
instance_type = "t2.micro"
key_name = "my-personal-key"
security_groups = ["${aws_security_group.web.name}"]
provisioner "file" {
  source="/home/test_copy"
  destination = "/home/ubuntu/test-copy"
}
connection {
 host = self.public_ip
 type = "ssh"
 user = var.AWS_SSH_USER
 private_key = file(var.AWS_PRIVATEKEY)
 }
provisioner "remote-exec" {
  inline = [
  "chmod +x /home/ubuntu/test-copy",
   "bash /home/ubuntu/test-copy"
  ]
}
provisioner "local-exec" {
command="echo private ip=${self.private_ip}>>hi.txt"

}
}
output "ip" {
value = aws_instance.instance1.public_ip
}
