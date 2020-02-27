output "public_instance_ip" {
  value = aws_instance.instance1.public_ip
}
output "private_instance_ip" {
  value = aws_instance.instance2.private_ip
}
