output "vpc_id" {
value = aws_vpc.test_vpc.id
}
output "public_subnet_id" {
value = aws_subnet.public_subnet.id
}
output "sg_id" {
value = aws_security_group.web.id
}
