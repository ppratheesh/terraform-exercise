resource "aws_key_pair" "pub-key" {
  key_name = "my-keys"
  public_key = file(var.PUBLIC_KEY)
}

resource "aws_instance" "instance1" {
   ami = var.AMIS[var.AWS_REGION]
   instance_type = "t2.micro"
   key_name = aws_key_pair.pub-key.key_name
   security_groups = ["${aws_security_group.web.name}"]
   root_block_device {
     volume_type = "gp2"
     volume_size = 10
     delete_on_termination = true
     }
     connection {
     type = "ssh"
     user = var.SSH-USER
     host = self.public_ip
     private_key = file(var.PRIVATE_KEY)
     }
  provisioner "file" {
  source = "my.sh"
  destination = "/tmp/my.sh"
  }
   provisioner "remote-exec" {
     inline = [
        "chmod +x /tmp/my.sh",
        "bash /tmp/my.sh"
     ]
   }

   provisioner "local-exec" {
   command = "echo private ip is ${self.private_ip} >>private_ip.txt"
   }
}
resource "aws_ebs_volume"  "personal-volume" {
  type = "gp2"
  size = 2
  availability_zone = aws_instance.instance1.availability_zone

}
resource "aws_volume_attachment" "volume_attach" {
  instance_id = aws_instance.instance1.id
  volume_id = aws_ebs_volume.personal-volume.id
  device_name = "/dev/xvdh"

}

resource "aws_security_group" "web" {
name="web_SG"
ingress {
from_port=22
to_port=22
protocol="tcp"
cidr_blocks=["0.0.0.0/0"]
}
ingress {
from_port=80
to_port=80
protocol="tcp"
cidr_blocks=["0.0.0.0/0"]
}
egress{
from_port=0
to_port=0
protocol="-1"
cidr_blocks=["0.0.0.0/0"]
 }
}
