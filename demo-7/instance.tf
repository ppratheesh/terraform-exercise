resource  "aws_instance" "instance1" {
  ami = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  key_name = "my-personal-key"
  subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = ["${aws_security_group.web.id}"]
  }
resource  "aws_instance" "instance2" {
    ami = var.AMIS[var.AWS_REGION]
    instance_type = "t2.micro"
    key_name = "my-personal-key"
    subnet_id = aws_subnet.private_subnet.id
    vpc_security_group_ids = ["${aws_security_group.web.id}"]
}
